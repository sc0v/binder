require "application_responder"

class ApplicationController < ActionController::Base

  before_action :set_event_list

  self.responder = ApplicationResponder
  respond_to :html
  responders :flash, :http_cache

  protect_from_forgery :with => :exception
  before_filter :sidebar

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  #checkin error handling
  #just need to fix routing for this and user // participant creation flow/path
  rescue_from 'Participant::NotRegistered' do |exception|
    flash[:notice] = "The Student ID you swiped is not yet activated with a user account. Please register with andrew eMail"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/participants/new"
  end

  rescue_from 'CheckoutsController::CheckoutError' do |exception|
    flash.now[:error] = exception.message
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    respond_to do |format|
      format.html { redirect_to "/tools" }
      format.json { render :json => exception.message, :status => :unprocessable_entity }
    end
  end

  rescue_from 'RestClient::Forbidden' do |exception|
    flash[:error] = "Cannot connect to CMU Authentication"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/"
  end

  def participant_already_in_system(participant)
    flash[:notice] = "The participant is already in the system - Update organizations for #{participant.name}"
  end
  
  def sidebar
    @current_shifts_sidebar = Shift.current
    @upcoming_shifts_sidebar = Shift.upcoming
    @tasks_sidebar = Task.upcoming.is_incomplete
    @structural_queue_sidebar = OrganizationTimelineEntry.structural.current
    @electrical_queue_sidebar = OrganizationTimelineEntry.electrical.current
    @events_sidebar = Event.displayable
    @downtime_sidebar = OrganizationTimelineEntry.downtime.current
    session[:tool_cart] = session[:tool_cart] || []
    @tool_cart = session[:tool_cart].map{|barcode| Tool.find_by_barcode(barcode)}.reverse
  end

  def require_authenticated_user
    if current_user.nil?
      redirect_to main_app.user_omniauth_authorize_path(:shibboleth)
    end
  end

  def authorize_report_access
    unless can?(:create, :reports)
      redirect_to root_path, notice: "You are not authorized to see reports"
    end
  end

  private

  def set_event_list
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events('sccakim1@gmail.com')
    
    rescue Google::Apis::AuthorizationError
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)

      retry
  end
  
  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end

end
