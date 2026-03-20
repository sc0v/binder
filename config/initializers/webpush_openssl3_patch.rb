# frozen_string_literal: true

# Patch webpush gem for OpenSSL 3.0 compatibility.
# OpenSSL 3.0 makes PKey objects immutable after creation, so webpush's
# approach of calling public_key= / private_key= after new() raises
# "pkeys are immutable". Instead we build the key from DER bytes up-front.
require 'webpush'

module Webpush
  module Encryption
    def encrypt(message, p256dh, auth)
      assert_arguments(message, p256dh, auth)

      group_name = 'prime256v1'
      salt = Random.new.bytes(16)

      server = OpenSSL::PKey::EC.generate(group_name)
      server_public_key_bn = server.public_key.to_bn

      group = OpenSSL::PKey::EC::Group.new(group_name)
      client_public_key_bn = OpenSSL::BN.new(Webpush.decode64(p256dh), 2)
      client_public_key = OpenSSL::PKey::EC::Point.new(group, client_public_key_bn)

      shared_secret = server.dh_compute_key(client_public_key)

      client_auth_token = Webpush.decode64(auth)

      info =
        "WebPush: info\0" +
          client_public_key_bn.to_s(2) +
          server_public_key_bn.to_s(2)
      content_encryption_key_info = "Content-Encoding: aes128gcm\0"
      nonce_info = "Content-Encoding: nonce\0"

      prk =
        HKDF.new(
          shared_secret,
          salt: client_auth_token,
          algorithm: 'SHA256',
          info: info
        ).next_bytes(32)

      content_encryption_key =
        HKDF.new(prk, salt: salt, info: content_encryption_key_info).next_bytes(16)
      nonce = HKDF.new(prk, salt: salt, info: nonce_info).next_bytes(12)

      ciphertext = encrypt_payload(message, content_encryption_key, nonce)

      serverkey16bn = convert16bit(server_public_key_bn)
      rs = ciphertext.bytesize
      raise ArgumentError, 'encrypted payload is too big' if rs > 4096

      "#{salt}" +
        [rs].pack('N*') +
        [serverkey16bn.bytesize].pack('C*') +
        serverkey16bn +
        ciphertext
    end
  end

  class VapidKey
    def initialize
      @curve = OpenSSL::PKey::EC.generate('prime256v1')
    end

    def self.from_keys(public_key, private_key)
      private_bytes = Base64.urlsafe_decode64(pad(private_key))
      public_bytes  = Base64.urlsafe_decode64(pad(public_key))

      asn1 = OpenSSL::ASN1::Sequence.new([
        OpenSSL::ASN1::Integer.new(OpenSSL::BN.new(1)),
        OpenSSL::ASN1::OctetString.new(private_bytes),
        OpenSSL::ASN1::ASN1Data.new(
          [OpenSSL::ASN1::ObjectId.new('prime256v1')], 0, :CONTEXT_SPECIFIC
        ),
        OpenSSL::ASN1::ASN1Data.new(
          [OpenSSL::ASN1::BitString.new(public_bytes)], 1, :CONTEXT_SPECIFIC
        )
      ])

      vapid_key = allocate
      vapid_key.instance_variable_set(:@curve, OpenSSL::PKey::EC.new(asn1.to_der))
      vapid_key
    end

    def self.pad(base64url)
      base64url + '=' * ((4 - base64url.length % 4) % 4)
    end
    private_class_method :pad
  end
end
