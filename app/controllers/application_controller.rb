class ApplicationController < ActionController::Base
  protect_from_forgery

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

  rescue_from 'CheckoutsController::OrganizationDoesNotExist' do |exception|
    flash[:error] = "The organization you entered is not registered with the system. Please register it if desired."
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/organization/new"
  end

  rescue_from 'CheckoutsController::ParticipantNotExist' do |exception|
    flash.now[:error] = "The Student ID you swiped is not yet activated with a user account. Please register with andrew eMail"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/participants/new"
  end

  rescue_from 'CheckoutsController::ToolAlreadyCheckedIn' do |exception|
    flash[:error] = "The Tool you selected is already checked in."
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/tools"
  end

  rescue_from 'CheckoutsController::ToolAlreadyCheckedOut' do |exception|
    flash[:error] = "The Tool you selected is already checked out."
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/tools"
  end

  rescue_from 'CheckoutsController::ToolDoesNotExist' do |exception|
    flash[:error] = "The Tool barcode you entered is not registered with the system. Please register it if desired."
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/tools"
  end

  rescue_from 'ShiftParticipantsController::ParticipantDoesNotMatch' do |exception|
    flash[:error] = "The participants don't match!"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/shifts"
  end

  rescue_from 'RestClient::Forbidden' do |exception|
    flash[:error] = "Cannot connect to CMU Authentication"
    #Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to "/"
  end

  def participant_already_in_system(participant)
    flash[:notice] = "The participant is already in the system - Update organizations for #{participant.name}"
  end
end