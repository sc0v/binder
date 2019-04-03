# ## Schema Information
#
# Table name: `certifications`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`active`**                 | `boolean`          | `default(TRUE)`
# **`certification_type_id`**  | `integer`          |
# **`created_at`**             | `datetime`         | `not null`
# **`id`**                     | `integer`          | `not null, primary key`
# **`participant_id`**         | `integer`          |
# **`updated_at`**             | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_certifications_on_certification_type_id`:
#     * **`certification_type_id`**
# * `index_certifications_on_participant_id`:
#     * **`participant_id`**
#

class CertificationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_participant, only: [:new, :create]
  before_action :set_certification, only: [:destroy]
  before_action :check_all_certifications, except: [:destroy]

  def new
    @certification = Certification.new(:participant => @participant)
    respond_with @certification
  end

  def create
    @certification = Certification.new(certification_params)
    @certification.participant = @participant
    @certification.save
    respond_with @certification, location: -> { @certification.participant }
  end

  def destroy
    @certification.destroy
    respond_with @certification, location: -> { @certification.participant }
  end

  private
  def set_participant
    @participant = Participant.find(params[:participant_id])
  end

  def set_certification
    @certification = Certification.find(params[:id])
  end

  def check_all_certifications
    if @participant.certifications.size == CertificationType.all.size
      redirect_to (participant_path @participant), :flash => { :error => @participant.name + " has already gotten all certifications." }
    end
  end

  def certification_params
    params.require(:certification).permit(:participant_id, :certification_type_id)
  end

end
