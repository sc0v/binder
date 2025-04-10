class OrganizationMembersController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    staged = @organization.memberships.where(is_staged: true)
    @new_chairs = staged.where(is_booth_chair: true).map { |m| m.participant }
    @new_builders = staged.where(is_booth_chair: false).map { |m| m.participant }
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @participant = Participant.find_or_create_by_search(params[:participant][:andrewid])
    back = new_organization_participant_path(@organization)

    if @participant
      # First check if membership already exists
      membership = Membership.find_by(organization: @organization, participant: @participant)
      if membership
        # Membership Exists, try to update the existing one
        membership.is_booth_chair = params[:participant][:booth_chair]
        membership.is_staged = true
        if membership.save
          redirect_to back, notice: "Member updated!"
        else
          redirect_to back, warn: "#{params[:participant][:andrewid]} already a member, but failed to update!"
        end
      else
        # Membership Doesn't Exist, try to add a new one
        if Membership.create( organization: @organization, 
          participant: @participant, 
          is_booth_chair: params[:participant][:booth_chair],
          is_staged: true )
          redirect_to back, notice: "Added #{params[:participant][:andrewid]}!"
        else
          redirect_to back, alert:  "Failed to add #{params[:participant][:andrewid]}!"    
        end
      end
    else
      redirect_to back, alert:  "Failed to add member #{params[:participant][:andrewid]}!"
    end
  end

  def index
    @organization = Organization.find(params[:organization_id])
    @members = Participant.in_organization(@organization)
                                  .ordered_by_name
    respond_to do |format|
      format.html
      format.json do
        data =
          @members.as_json(
            methods: %i[link name signed_waiver? is_booth_chair?]
            )
        render json: { data: }
      end
    end
  end

  # Sets staged=false for all memberships in org to remove list of people from
  # the top of the "new" view 
  def remove_staged
    @organization = Organization.find(params[:organization_id])
    staged = @organization.memberships.where(is_staged: true)
    staged.each do |m|
      m.is_staged = false
      m.save!
    end
    redirect_to organization_path(@organization), notice: "New Members Saved!"
  end
end
