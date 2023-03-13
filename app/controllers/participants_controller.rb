# frozen_string_literal: true

class ParticipantsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create]
  # before_action :set_participant, only: %i[show edit update destroy]
  before_action :set_wristband_colors

  # GET /participants
  # GET /participants.json
  def index
    if params[:organization_id].blank?
      @participants = Participant.all
    else
      @organization = Organization.find(params[:organization_id])
      @participants = @organization.participants
    end

    # @participants = @participants.paginate(:page => params[:page]).per_page(20)
  end

  def search
    query = params[:q]
    return if query.blank?

    # TODO:
    # @andrew_people = Participant.filter(keyword: query)
    @andrew_people = []

    respond_to do |format|
      format.json do
        render json: @andrew_people.to_json
      end
    end
  end

  def lookup
    # Process request if barcode is present
    participant = Participant.find_by card: params[:card_number]

    if participant.blank?
      render json: :nothing, status: :unprocessable_entity
    else
      render json: { id: participant.id,
                     name: participant.name,
                     member_orgs: participant.organizations,
                     non_member_orgs: Organization.all.reject { |org| participant.organizations.exclude?(org) } }
    end
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @participant = show_participant(params[:id])

    @memberships = @participant.memberships.all

    if @memberships.empty?
      @wristband = 'None - No organizations'
    elsif !@participant.has_signed_waiver
      @wristband = 'None - No waiver signature'
    else
      building_statuses = @memberships.map { |m| m.organization.organization_category.is_building }
      @wristband = if building_statuses.include?(true)
                     @wristband_colors[:building]
                   else
                     @wristband_colors[:nonbuilding]
                   end

      certs = @participant.certifications.map(&:certification_type)
      if certs.include?(CertificationType.find_by(name: 'Scissor Lift'))
        @wristband += " and #{@wristband_colors[:scissor_lift]}"
      end
    end
  end

  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit; end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_create_params)
    @participant.save
    respond_with(@participant)
  end

  # PUT /participants/1
  # PUT /participants/1.json
  def update
    @participant.update(participant_update_params)
    respond_with(@participant)
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_with(@participant)
  end

  private

  def show_participant(uid = nil)
    return Current.user unless Current.user.admin?
    return Current.user if uid.blank?

    find_or_create_participant(uid)
  end

  def find_or_create_participant(uid)
    p = Participant.find_or_create_by! andrewid: uid
    p.update_ldap_attrs
    p
  rescue ActiveRecord::RecordInvalid => e
    # TODO: participants_url/did you mean? results
    # redirect_to('/',
    flash['error'] = '<strong>Participant does not exist.</strong> ' \
                     "#{e.record.errors.full_messages.join(', ')}"
    redirect_to root_url
  rescue ActiveRecord::RecordNotUnique
    # Mitigate the race condition if an unrelated insert happens after this
    # lookup fails
    retry
  end

  # def set_participant
  #  @participant = Participant.find(params[:id])
  # end

  def participant_create_params
    params.require(:participant).permit(:eppn, :phone_number, :has_signed_waiver, :has_signed_hardhat_waiver)
  end

  def participant_update_params
    params.require(:participant).permit(:phone_number, :has_signed_waiver, :has_signed_hardhat_waiver)
  end

  def set_wristband_colors
    @wristband_colors = { building: 'Red', nonbuilding: 'Blue', scissor_lift: 'Green' }
  end
end
