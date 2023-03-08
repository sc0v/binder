# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  slo = if Rails.env.production?
          '/Shibboleth.sso/Logout?return=/'
        else
          '/'
        end

  provider :shibboleth, {
    debug: !Rails.env.production?,
    fail_with_empty_uid: true,
    idp_slo_service_url: slo,
    uid_field: 'eduPersonPrincipalName',
    name_field: 'displayName',
    info_fields: {
      email: 'mail'
    }
  }
end

OmniAuth.config.logger = Rails.logger

unless Rails.env.production?
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:shibboleth] =
    OmniAuth::AuthHash.new({ provider: 'shibboleth',
                             uid: 'andrewcarnegie0@andrew.cmu.edu',
                             name: 'Andrew Carnegie',
                             info: { email: 'andrewcarnegie0@andrew.cmu.edu' } })
end
