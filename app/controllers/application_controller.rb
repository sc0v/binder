# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  # TODO: Review everything below

  # checkin error handling
  # just need to fix routing for this and user // participant creation flow/path
  rescue_from 'Participant::NotRegistered' do |_exception|
    flash[:notice] =
      'The Student ID you swiped is not yet activated with a user account. Please register with andrew eMail'

    # Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to '/participants/new'
  end

  rescue_from 'CheckoutsController::CheckoutError' do |exception|
    flash.now[:error] = exception.message

    # Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    respond_to do |format|
      format.html { redirect_to '/tools' }
      format.json do
        render json: exception.message, status: :unprocessable_entity
      end
    end
  end

  rescue_from 'RestClient::Forbidden' do |_exception|
    flash[:error] = 'Cannot connect to CMU Authentication'

    # Event.new_event "Exception: #{exception.message}", current_user, request.remote_ip #deugging
    redirect_to '/'
  end

  def participant_already_in_system(participant)
    flash.now[:notice] =
      "The participant is already in the system - Update organizations for #{participant.name}"
  end
end
