class MembershipsController < ApplicationController
  load_and_authorize_resource 
  skip_load_resource :only => [:create]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  #declare error / info classes
  class OrganizationNotExist < Exception
  end

  class ParticipantNotExist < Exception
  end

  # POST
  def create
    @new_organization_ids = params.require(:organization_ids)

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
      if(!@new_organization_ids.include?(org.id.to_s))
        @membership = Membership.find(:first, :conditions => [ "participant_id = ? AND organization_id = ?", @participant.id, org.id])
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

          if(!@membership.save!)
            all_ok = false
            break
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @participant = Participant.find(params[:participant_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit
    @participant = Participant.find(params[:participant_id])
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @participant = Participant.find(params[:participant_id])
    
    respond_to do |format|
      if @membership.update_attributes(update_params)
        format.html { redirect_to @participant, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @participant = Participant.find(params[:participant_id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to @participant }
      format.json { head :no_content }
    end
  end
  
  private
  
  def update_params
    params.require(:membership).permit(:is_booth_chair, :title, :booth_chair_order)
  end
end