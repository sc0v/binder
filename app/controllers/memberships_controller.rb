class MembershipsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET
  def new_participant_membership
    @membership = Membership.new

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

  def add_participant_memberships
    # check if we are simply trying to add new memberships to an already existing participant (from participant#show)
    if(params.has_key?(:participant_id_to_add_to))
      # we are adding to an already existing participant
      @participant = Participant.find(params[:participant_id_to_add_to])
    else
      # we are trying to create a new participant
      @participant = Participant.new(params[:participant])
      @participant.andrewid = Participant.get_andrewid(params[:participant][:card_number])
    end

    if(Participant.find_by_andrewid(@participant.andrewid).nil?)
      @participant.save!
    else
      participant_already_in_system(@participant)

      @participant = Participant.find_by_andrewid(@participant.andrewid)
    end

    @membership = Membership.new

    respond_to do |format|
      format.html # add_participant_memberships.html.erb
      format.json { render json: @memberships }
    end
  end

  # POST
  def create_participant_memberships
    @new_organization_ids = params[:organization_ids]
    @participant_id = params[:membership][:participant_id]

    @participant = Participant.find_by_id(@participant_id)
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
        @membership.destroy
      end
    end

    all_ok = true

    # create new memberships (only if they don't have a membership already)
    if(!@new_organization_ids.nil?)
      @new_organization_ids.each do |new_org_id|
        if(!@participant.organizations.map{|o| o.id.to_s}.include?(new_org_id.to_s))
          @membership = Membership.new
          @membership.participant_id = @participant_id
          @membership.organization = Organization.find_by_id(new_org_id)

          if(!@membership.save!)
            all_ok = false
            break
          end
        end
      end
    end

    # update user role
    @role_ids = params[:membership][:role_ids]

    if(!@role_ids.nil?)
      @user = User.find_by_email(@participant.email)

      if(@user.nil?)
        @user = User.new
        @user.email = @participant.email
        @user.password = "testtest"
        @user.password_confirmation = "testtest"
        @user.name = @participant.name
        @user.add_role Role::ROLES[@role_ids.to_i - 1]
        @user.save!
      end

      @participant.user_id = @user.id
      @participant.save!
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

  # POST
  def create_participant_membership
    @membership = Membership.new(params[:membership])
    # @organization = Organization.find(params[:id])
    # raise OrganizationDoesNotExist unless !@organization.nil?

    @participant = Participant.find_by_card(@membership.participant_id) #this creates a CMU directory request to get the andrew id associated with the card number. Then finds the local DB mapping to get the participant id.
    raise ParticipantDoesNotExist unless @participant.nil?

    @membership.participant_id = @participant.id

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
        format.json { render json: @membership, status: :created, location: @membership }
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
    @membership = Membership.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(params[:membership])

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
        format.json { render json: @membership, status: :created, location: @membership }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
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
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end
end