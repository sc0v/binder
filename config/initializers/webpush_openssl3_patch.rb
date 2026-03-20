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
      salt = Random.new.bytes(16)
      server, server_pk_bn, client_pk_bn, client_pk = generate_ec_keys(p256dh)
      cek, nonce = derive_keys(
        server.dh_compute_key(client_pk),
        Webpush.decode64(auth), client_pk_bn, server_pk_bn, salt
      )
      ciphertext = encrypt_payload(message, cek, nonce)
      raise ArgumentError, 'encrypted payload is too big' if ciphertext.bytesize > 4096

      build_header(salt, convert16bit(server_pk_bn), ciphertext)
    end

    private

    def generate_ec_keys(p256dh)
      server = OpenSSL::PKey::EC.generate('prime256v1')
      server_pk_bn = server.public_key.to_bn
      group = OpenSSL::PKey::EC::Group.new('prime256v1')
      client_pk_bn = OpenSSL::BN.new(Webpush.decode64(p256dh), 2)
      client_pk = OpenSSL::PKey::EC::Point.new(group, client_pk_bn)
      [server, server_pk_bn, client_pk_bn, client_pk]
    end

    def derive_keys(shared_secret, client_auth_token, client_pk_bn, server_pk_bn, salt)
      info = "WebPush: info\0#{client_pk_bn.to_s(2)}#{server_pk_bn.to_s(2)}"
      prk = HKDF.new(shared_secret, salt: client_auth_token, algorithm: 'SHA256',
                                    info: info).next_bytes(32)
      cek = HKDF.new(prk, salt: salt, info: "Content-Encoding: aes128gcm\0").next_bytes(16)
      nonce = HKDF.new(prk, salt: salt, info: "Content-Encoding: nonce\0").next_bytes(12)
      [cek, nonce]
    end

    def build_header(salt, serverkey16bn, ciphertext)
      salt.to_s +
        [ciphertext.bytesize].pack('N*') +
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
      base64url + ('=' * ((4 - (base64url.length % 4)) % 4))
    end
    private_class_method :pad
  end
end
