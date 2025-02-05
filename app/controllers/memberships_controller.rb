# frozen_string_literal: true

class MembershipsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: %i[new create update]
  #responders :flash, :http_cache

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # declare error / info classes
  class OrganizationNotExist < StandardError
  end

  class ParticipantNotExist < StandardError
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = Membership.find(params[:id])
  end

  def new
    @organization = Organization.find(params.require(:organization_id))
    @membership = Membership.new
    @membership.organization = @organization

    if params[:step].nil?
      params[:step] = 'csv_upload'
    end
    
    if params[:step] == 'repair'
      @members = Membership.where(organization: @organization, is_in_csv: true)
    end
  end

  def upload_csv
    @organization = Organization.find(params[:organization])
    # Make sure user uploaded a file
    if params[:csv_file].blank?
      redirect_to new_organization_membership_path(@organization), alert: 'CSV Not Uploaded!' and return
    end
    # Make sure the file parsed successfully
    parse = helpers.parse_membership_csv(params[:csv_file], @organization)
    if parse[:error].present?
      redirect_to new_organization_membership_path(@organization), alert: parse[:error] and return
    end
    redirect_to new_organization_membership_path(@organization, step: 'repair')
  end

  # Insert a participant to the current membership CSV
  def insert
    @organization = Organization.find(params[:organization])

    # Find or create new participant
    new_eppn = "#{params[:new_participant]}@andrew.cmu.edu"
    new_participant = Participant.find_by(eppn: new_eppn)
    if new_participant.nil?
      new_participant = Participant.create!(eppn: new_eppn)
    end
    # Create new Membership, or just set is_in_csv if it already exists
    m = Membership.find_by(participant: new_participant, organization: @organization)
    if m.nil?
      m = Membership.create!({
        participant: new_participant,
        organization: @organization,
        is_in_csv: true,
        is_added_by_csv: true,
      })
    else
      m.update!({is_in_csv: true})
    end
  
    if !params[:ignore_redirect]
      redirect_to new_organization_membership_path(@organization, step: 'repair')
    end
  end

  def remove
    @organization = Organization.find(params[:organization])
    # If the membership we're replacing was added by the CSV, destroy it
    # Otherwise, just remove from the CSV
    old_membership = Membership.find(params[:old_membership])
    if old_membership.is_added_by_csv
      old_participant = old_membership.participant
      old_membership.destroy!
      # If old participant now has no memberships, destroy them too
      if Membership.where(participant: old_participant).blank?
        old_participant.destroy!
      end
    else
      old_membership.update!({is_in_csv: false})
    end

    if !params[:ignore_redirect]
      redirect_to new_organization_membership_path(@organization, step: 'repair')
    end
  end

  # Replace one staged membership with another, while respecting any participant's
  # other memberships
  def replace
    # Remove old membership
    params[:ignore_redirect] = true
    remove()
    # Find or create new membership
    params[:ignore_redirect] = false
    insert()
  end

  # Cancel all staged memberships, deleting any that were added by the csv
  def cancel
    @organization = Organization.find(params[:organization])
    Membership.where(organization: @organization, is_in_csv: true).each do |m|
      if m.is_added_by_csv
        participant = m.participant
        m.destroy!
        # If participant now has no memberships, destroy them too
        if Membership.where(participant: participant).blank?
          participant.destroy!
        end
      else
        m.update!({is_in_csv: false})
      end
    end
    redirect_to organization_path(@organization), notice: "Cancelled!"
  end

  # Commit all staged memberships
  def commit
    @organization = Organization.find(params[:organization])
    Membership.where(organization: @organization, is_in_csv: true).each do |m|
      m.update!({is_in_csv: false, is_added_by_csv: false})
    end
    redirect_to organization_path(@organization), notice: "Participants Added!"
  end

  # GET /memberships/1/edit
  def edit
    @participant = Participant.find(params[:participant_id])
  end

  def create
    @membership = Membership.new(params.require(:membership).permit(:participant_id, :is_booth_chair))
    @organization = Organization.find(params.require(:organization_id))
    @membership.organization = @organization
    authorize! :create, @membership
    if @membership.save
      flash[:notice] = 'Member added'
    else
      flash[:error] = 'Error adding member'
    end
    redirect_to @organization
  end

  # POST
  def old_create
    @new_organization_ids = params.permit(organization_ids: [])[:organization_ids]
    logger.info(@new_organization_ids)

    @participant = Participant.find(params.require(:participant_id))
    raise ParticipantDoesNotExist if @participant.nil?

    # make sure all organizations exist
    @new_organization_ids&.each do |org_id|
      @organization = Organization.find(org_id)
      raise OrganizationDoesNotExist if @organization.nil?
    end

    # delete any organizations that were previously added, but not checked on submission
    @old_participant_orgs = @participant.organizations

    @old_participant_orgs.each do |org|
      if @new_organization_ids.blank? || @new_organization_ids.exclude?(org.id.to_s)
        @membership = Membership.where(participant_id: @participant.id, organization_id: org.id).first
        @membership.destroy unless @membership.is_booth_chair?
      end
    end

    all_ok = true

    # create new memberships (only if they don't have a membership already)
    @new_organization_ids&.each do |new_org_id|
      next unless @participant.organizations.map { |o| o.id.to_s }.exclude?(new_org_id.to_s)

      @membership = Membership.new
      @membership.participant = @participant

      @membership.organization = Organization.find_by(id: new_org_id)
      unless @membership.save!
        all_ok = false
        break
      end
    end

    respond_to do |format|
      if all_ok
        format.html { redirect_to @participant, notice: 'Participant updated.' }
        format.json { render json: @participant, status: :created, location: @participant }
      else
        format.html { render action: 'new' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def old_new
    @participant = Participant.find(params[:participant_id])
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @participant = Participant.find(params[:participant_id])
    @membership = Membership.find(params[:id])
    authorize! :update, @membership
    @membership.update(update_params)
    respond_with @membership, location: -> { @participant }
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @organization = @membership.organization
    @membership.destroy
    redirect_to @organization
  end

  private

  def update_params
    params.require(:membership).permit(:is_booth_chair, :title, :booth_chair_order)
  end
end
