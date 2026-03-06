# frozen_string_literal: true

sp_cert = Rails.root.join('config/private/sp-cert.pem')
sp_key = Rails.root.join('config/private/sp-key.pem')

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  settings =
    OneLogin::RubySaml::IdpMetadataParser.new.parse_remote_to_hash(
      'https://login.cmu.edu/idp/shibboleth',
      true,
      { sso_binding: 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect' }
    )

  settings.merge!(
    certificate: sp_cert.exist? ? sp_cert.read : nil,
    private_key: sp_key.exist? ? sp_key.read : nil,
    sp_entity_id: 'binder.springcarnival.org/auth/saml',
    uid_attribute: 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6' # eduPersonPrincipalName
  )

  provider :saml, settings
end
