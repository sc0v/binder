# frozen_string_literal: true
class OrganizationsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource

  def index
    pagy, organizations =
      pagy(Organization.accessible_by(Current.ability).ordered_by_name)
    respond_to do |format|
      format.html
      format.json do
        data =
          organizations.as_json(
            methods: %i[building? category_name link remaining_downtime downtime_link]
          )
        render json: { last_page: pagy.pages, data: data }
      end
    end
  end

  def show
    # @booth_chairs = @organization.booth_chairs
    # @tools = Tool.checked_out_by_organization(@organization).just_tools
    # @shifts = @organization.shifts
    # @participants = @organization.participants
    # @charges = @organization.charges

      pagy, participants =
        pagy(@organization.participants.accessible_by(Current.ability).ordered_by_name)
      respond_to do |format|
        format.html
        format.json do
          data =
            participants.as_json(
              methods: %i[link name signed_waiver? is_booth_chair?]
             )
          render json: { last_page: pagy.pages, data: data }
        end
      end

    # Get Structural Build Status
    @structural = @organization.organization_build_statuses.find_by(status_type: :structural)
    @electrical = @organization.organization_build_statuses.find_by(status_type: :electrical)

    # Get Total Fines for Organization
    @total_fines = 0
    @organization.charges.each do |charge|
      @total_fines += charge.amount
    end
    # Get Tools Checked Out by Organization
    @tools_checked_out = Tool.checked_out_by_organization(@organization)
    # Get Members of Organization
    @members = @organization.participants
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
