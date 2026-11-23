# frozen_string_literal: true

class OrganizationMembersController < ApplicationController
  def index
    @organization = Organization.find(params[:organization_id])
    authorize! :read, Membership.new(organization: @organization)
    members = Participant.accessible_by(Current.ability)
                         .in_organization(@organization)
                         .ordered_by_name
    @table_rows = members.as_json(
      only: %i[id eppn],
      methods: %i[link name signed_waiver? booth_chair?]
    )
    respond_to do |format|
      format.html
      format.json { render json: { data: @table_rows } }
    end
  end

  def new
    @organization = Organization.find(params[:organization_id])
    staged = @organization.memberships.where(is_staged: true)
    @new_chairs = staged.where(is_booth_chair: true).map(&:participant)
    @new_builders = staged.where(is_booth_chair: false).map(&:participant)
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @participant =
      Participant.find_or_create_by_search(params[:participant][:andrewid])
    back = new_organization_participant_path(@organization)

    if @participant
      # First check if membership already exists
      membership =
        Membership.find_by(
          organization: @organization,
          participant: @participant
        )
      if membership
        # Membership Exists, try to update the existing one
        membership.is_booth_chair = params[:participant][:booth_chair]
        membership.is_staged = true
        if membership.save
          redirect_to back, notice: t('.member_updated')
        else
          redirect_to back,
                      warn:
                        "#{params[:participant][:andrewid]} already a member, but failed to update!"
        end
      elsif Membership.create(
            organization: @organization,
            participant: @participant,
            is_booth_chair: params[:participant][:booth_chair],
            is_staged: true
          )
        # Membership Doesn't Exist, try to add a new one
        redirect_to back, notice: "Added #{params[:participant][:andrewid]}."
      else
        redirect_to back,
                    alert: "#{params[:participant][:andrewid]} couldn't be added. Check the Andrew ID and try again."
      end
    else
      redirect_to back,
                  alert:
                    "Failed to add member #{params[:participant][:andrewid]}!"
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
    redirect_to organization_path(@organization), notice: t('.notice')
  end
end
