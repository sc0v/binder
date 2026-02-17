# frozen_string_literal: true
class OrganizationsController < ApplicationController
  load_and_authorize_resource

  def index
    organizations = Organization.accessible_by(Current.ability).ordered_by_name
    respond_to do |format|
      format.html
      format.json do
        page = params[:page].present? ? params[:page].to_i : 1
        size = params[:size].present? ? params[:size].to_i : 1

        offset = (page - 1) * size
        last_page = organizations.count / size + (organizations.count % size == 0 ? 0 : 1)
        organizations = organizations.offset(offset).limit(size)
        data =
          organizations.as_json(
            methods: %i[building? category_name link remaining_downtime downtime_link]
          )
        data.each do |d|
          d["remaining_downtime"] = helpers.format_duration d["remaining_downtime"]
        end
        render json: { last_page:, data: }
      end
    end
  end

  def show
    @booth_chairs = @organization.booth_chairs
    @non_booth_chairs = @organization.validated_non_booth_chairs
    @tools = Tool.checked_out_by_organization(@organization).just_tools
    @shifts = @organization.shifts
    @participants = @organization.validated_participants

    respond_to do |format|
      format.html
      format.json do
        page = params[:page].present? ? params[:page].to_i : 1
        size = params[:size].present? ? params[:size].to_i : 1

        participants = @organization.participants.accessible_by(Current.ability).ordered_by_name
        offset = (page - 1) * size
        last_page = participants.count / size + (participants.count % size == 0 ? 0 : 1)
        participants = participants.offset(offset).limit(size)
        data =
          participants.as_json(
            methods: %i[link name signed_waiver? is_booth_chair?]
          )
        render json: { last_page:, data: }
      end
    end

    # Get Structural Build Status
    @structural = @organization.organization_build_statuses.find_by(status_type: :structural)
    @electrical = @organization.organization_build_statuses.find_by(status_type: :electrical)

    # Get Tools Checked Out by Organization
    @tools_checked_out = Tool.just_tools.checked_out_by_organization(@organization)
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new; end

  # GET /organizations/1/edit
  def edit; end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization.save
    respond_with(@organization)
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization.update(organization_params)
    respond_with(@organization)
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_with(@organization)
  end

  def hardhats
    @hardhats = Tool.checked_out_by_organization(@organization).hardhats
  end

  private

  def organization_params
    params
      .require(:organization)
      .permit(:name, :short_name, :organization_category_id)
  end
end
