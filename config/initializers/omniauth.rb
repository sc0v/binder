# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.logger = Rails.logger

  idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
  validate_cert = true
  options = {
    sso_binding: 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect'
  }
  settings = idp_metadata_parser.parse_remote_to_hash(
    'https://login.cmu.edu/idp/shibboleth',
    validate_cert,
    options
  )

  settings.merge!(
    certificate: File.read(Rails.root.join('config', 'sp-cert.pem')),
    private_key: File.read(Rails.root.join('config', 'sp-key.pem')),
    sp_entity_id: "binder.springcarnival.org/auth/saml",
    uid_attribute: 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6', # eduPersonPrincipalName
  )

  provider :saml, settings
end
