# ## Schema Information
#
# Table name: `participants`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`andrewid`**                   | `string`           |
# **`cache_updated`**              | `datetime`         |
# **`cached_department`**          | `string`           |
# **`cached_email`**               | `string`           |
# **`cached_name`**                | `string`           |
# **`cached_student_class`**       | `string`           |
# **`cached_surname`**             | `string`           |
# **`created_at`**                 | `datetime`         |
# **`has_signed_hardhat_waiver`**  | `boolean`          |
# **`has_signed_waiver`**          | `boolean`          |
# **`id`**                         | `integer`          | `not null, primary key`
# **`phone_carrier_id`**           | `integer`          |
# **`phone_number`**               | `string`           |
# **`updated_at`**                 | `datetime`         |
# **`user_id`**                    | `integer`          |
# **`waiver_start`**               | `datetime`         |
#
# ### Indexes
#
# * `index_participants_on_phone_carrier_id`:
#     * **`phone_carrier_id`**
#

#
# ### Indexes
#
# * `index_participants_on_phone_carrier_id`:
#     * **`phone_carrier_id`**
#

class ParticipantsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :set_wristband_colors

  # GET /participants
  # GET /participants.json
  def index
    unless ( params[:organization_id].blank? )
      @organization = Organization.find(params[:organization_id])
      @participants = @organization.participants
    else
      @participants = Participant.all
    end

    @participants = @participants.paginate(:page => params[:page]).per_page(20)
  end

  def lookup
    # Process request if barcode is present
    participant = Participant.find_by_card params[:card_number]
   
    unless participant.blank?
      render json: { :id => participant.id,
                     :name => participant.name,
                     :member_orgs => participant.organizations,
                     :non_member_orgs => Organization.all.select{|org| !participant.organizations.include?(org)}
      }
    else
      render json: :nothing, status: :unprocessable_entity
    end
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @memberships = @participant.memberships.all

    if @memberships.empty?
      @wristband = "None - No organizations"
    elsif !@participant.has_signed_waiver
      @wristband = "None - No waiver signature"
    else
      building_statuses = @memberships.map { |m| m.organization.organization_category.is_building }
      if building_statuses.include?(true)
        @wristband = @wristband_colors[:building]
      else
        @wristband = @wristband_colors[:nonbuilding]
      end

      certs = @participant.certifications.map { |cert| cert.certification_type }
      if certs.include?(CertificationType.find_by_name("Scissor Lift"))
        @wristband += " and " + @wristband_colors[:scissor_lift]
      end
    end
  end

  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

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
    @participant.update_attributes(participant_update_params)
    respond_with(@participant)
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_with(@participant)
  end

  private
  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_create_params
    params.require(:participant).permit(:andrewid, :phone_number, :has_signed_waiver, :has_signed_hardhat_waiver)
  end

  def participant_update_params
    params.require(:participant).permit(:phone_number, :has_signed_waiver, :has_signed_hardhat_waiver)
  end

  def set_wristband_colors
    @wristband_colors = { :building => "Red", :nonbuilding => "Blue", :scissor_lift => "Green" }
  end

end
