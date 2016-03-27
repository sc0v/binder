Rails.application.config.to_prepare do
  # Use Authority to enforce viewing permissions for this report.
  # You might set the report's `authorizer_name` to 'ReportsAuthorizer', and
  # define that with a `readable_by?(user)` method that suits your needs
  Dossier::ReportsController.before_filter :authorize_report_access
end