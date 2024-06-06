# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  slo = (Rails.env.production? ? '/Shibboleth.sso/Logout?return=/' : '/')

  provider :shibboleth,
           {
             debug: !Rails.env.production?,
             fail_with_empty_uid: true,
             idp_slo_service_url: slo,
             uid_field: 'eppn',
             name_field: 'displayName',
             info_fields: {
               email: 'mail'
             }
           }
end

OmniAuth.config.logger = Rails.logger

# unless Rails.env.production?
#   OmniAuth.config.test_mode = true

#   OmniAuth.config.mock_auth[:shibboleth] = OmniAuth::AuthHash.new(
#     {
#       provider: 'shibboleth',
#       uid: 'andrewcarnegie0@andrew.cmu.edu',
#       name: 'Andrew Carnegie',
#       info: {
#         email: 'andrewcarnegie0@andrew.cmu.edu'
#       }
#     }
#   )
# end

unless Rails.env.production?
  OmniAuth.config.test_mode = true
  participants_path = Rails.root.join('test', 'fixtures', 'participants.yml')
  PARTICIPANTS = YAML.load_file(participants_path)

  def set_mock_auth(participant_key)
    participant = PARTICIPANTS[participant_key]
    raise "No participant found for key: #{participant_key}" unless participant

    OmniAuth.config.mock_auth[:shibboleth] = OmniAuth::AuthHash.new(
      provider: 'shibboleth',
      uid: participant['eppn'],
      info: {
        name: participant['cached_name'],
        email: participant['cached_email']
      }
    )
  end
  set_mock_auth("admin_participant")
end