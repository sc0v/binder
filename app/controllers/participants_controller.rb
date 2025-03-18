# frozen_string_literal: true
class ParticipantsController < ApplicationController
  include PersonalPathable
  before_action :require_authentication
  load_and_authorize_resource

  # Index method with manual pagination using page and size parameters
  # The participants table gets data from here through AJAX, so we keep
  # compute last_page to tell table how many batches it needs
  def index
    respond_to do |format|
      format.html
      format.json do
        page = params[:page].present? ? params[:page].to_i : 1
        size = params[:size].present? ? params[:size].to_i : 1

        offset = (page-1)*size
        # Compute last_page as ceil(Participant.count / size)
        last_page = Participant.count / size + (Participant.count % size == 0 ? 0 : 1)
        # Only return the participants in this page
        participants = Participant.accessible_by(Current.ability)
                        .ordered_by_name.offset(offset).limit(size)
        data =
          participants.table_attrs.as_json(
            methods: %i[link name signed_waiver?]
           )
        render json: { last_page: , data: }
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
