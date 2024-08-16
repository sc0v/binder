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
