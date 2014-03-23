class ApplicationController < ActionController::Base
  protect_from_forgery
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
    flash[:error] = exception.message
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    respond_to do |format|
      format.html { redirect_to "/tools" }
      format.json { render :json => exception.to_json, :status => :unprocessable_entity }
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
    @current_shifts = Shift.current
    @upcoming_shifts = Shift.upcoming
    @tasks = Task.upcoming
    
  end
end