# frozen_string_literal: true
class ParticipantsController < ApplicationController
  include Pagy::Backend
  include PersonalPathable
  before_action :require_authentication
  before_action -> { fix_personal_path(participants_path, params[:id].to_i) },
                :load_participant,
                only: :show
  load_and_authorize_resource

  def index
    pagy, participants =
      pagy(Participant.accessible_by(Current.ability).ordered_by_name)
    respond_to do |format|
      format.html
      format.json do
        data =
          participants.as_json(
            methods: %i[link name signed_waiver? is_booth_chair?]
           )
        render json: { last_page: pagy.pages, data: }
      end
    end
  end

  def search
    query = params[:q]
    return if query.blank?

    # TODO:
    # @andrew_people = Participant.filter(keyword: query)
    @andrew_people = []

    respond_to { |format| format.json { render json: @andrew_people.to_json } }
  end

  def lookup
    # Process request if barcode is present
    participant = Participant.find_by card: params[:card_number]

    if participant.blank?
      render json: :nothing, status: :unprocessable_entity
    else
      render json: {
               id: participant.id,
               name: participant.name,
               member_orgs: participant.organizations,
               non_member_orgs:
                 Organization.all.reject do |org|
                   participant.organizations.exclude?(org)
                 end
             }
    end
  end

  def show
    unless @participant.signed_waiver?
      flash.now[:alert] = "#{@participant.name} has not signed the waiver."
    end
   # @memberships = @participant.memberships.all

      #elsif !@participant.has_signed_waiver
      #  @wristband = 'None - No waiver signature'
      #else
      #building_statuses = @memberships.map { |m| m.organization.organization_category.building }
      #building_statuses = []
      #@wristband =
      #  if building_statuses.include?(true)
      #    @wristband_colors[:building]
      #  else
      #    @wristband_colors[:nonbuilding]
      #  end

      #certs = @participant.certifications.map(&:certification_type)
      #if certs.include?(CertificationType.find_by(name: 'Scissor Lift'))
      #  @wristband += " and #{@wristband_colors[:scissor_lift]}"
      #end
    #end
  end

  def new
  end

  def edit
  end

  def update
    @participant.update(participant_update_params)
    respond_with(@participant)
  end

  def destroy
    @participant.destroy
    respond_with(@participant)
  end

  private

  def show_participant(uid = nil)
    return Current.user unless Current.user.admin?
    return Current.user if uid.blank?

    #find_or_create_participant(uid)
  end

  def find_or_create_participant(_uid)
    Participant.find_or_create_by! eppn: p.update_ldap_attrs

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
  def set_wristband_colors
    @wristband_colors = {
      building: 'Red',
      nonbuilding: 'Blue',
      scissor_lift: 'Green'
    }
  end
  # def set_participant
  #  @participant = Participant.find(params[:id])
  # end

  def create_params
    params.require(:participant).permit(
      :eppn
    )
  end

  def update_params
    params.require(:participant).permit(
      Current.ability.permitted_attributes(:update, @participant)
    )
  end

  def load_participant
    @participant = Current.user if params[:id].blank?
  end
end
