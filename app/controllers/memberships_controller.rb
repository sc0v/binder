class MembershipsController < ApplicationController
  load_and_authorize_resource 
  skip_load_resource :only => [:create, :update]
  responders :flash, :http_cache

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  #declare error / info classes
  class OrganizationNotExist < Exception
  end

  class ParticipantNotExist < Exception
  end

  # POST
  def create
    @new_organization_ids = params.permit(:organization_ids => [])[:organization_ids]
    logger.info(@new_organization_ids)

    @participant = Participant.find(params.require(:participant_id))
    raise ParticipantDoesNotExist unless !@participant.nil?

    if(!@new_organization_ids.nil?)
      # make sure all organizations exist
      @new_organization_ids.each do |org_id|
        @organization = Organization.find(org_id)
        raise OrganizationDoesNotExist unless !@organization.nil?
      end
    end

    # delete any organizations that were previously added, but not checked on submission
    @old_participant_orgs = @participant.organizations

    @old_participant_orgs.each do |org|
      if (@new_organization_ids.blank? or !@new_organization_ids.include?(org.id.to_s))
        @membership = Membership.where(participant_id: @participant.id, organization_id: org.id).first
        @membership.destroy unless @membership.is_booth_chair?
      end
    end

    all_ok = true

    # create new memberships (only if they don't have a membership already)
    if(!@new_organization_ids.nil?)
      @new_organization_ids.each do |new_org_id|
          if(!@participant.organizations.map{|o| o.id.to_s}.include?(new_org_id.to_s))

            @membership = Membership.new
            @membership.participant = @participant
          
            @membership.organization = Organization.find_by_id(new_org_id)
            if @membership.organization.name!="Spring Carnival Committee" or @participant.is_scc?
            if(!@membership.save!)
              all_ok = false
              break
            end
            end
        end
      end
    end

    respond_to do |format|
      if all_ok
        format.html { redirect_to @participant, notice: 'Participant updated.' }
        format.json { render json: @participant, status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = Membership.find(params[:id])
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @participant = Participant.find(params[:participant_id])
  end

  # GET /memberships/1/edit
  def edit
    @participant = Participant.find(params[:participant_id])
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @participant = Participant.find(params[:participant_id])
    @membership.update_attributes(update_params)
    respond_with @membership, location: -> { @participant }
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @participant = Participant.find(params[:participant_id])
    @membership.destroy
    respond_with @membership, location: -> { @participant }
  end
  
  private
  
  def update_params
    params.require(:membership).permit(:is_booth_chair, :title, :booth_chair_order)
  end
end
