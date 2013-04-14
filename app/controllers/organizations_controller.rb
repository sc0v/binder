class OrganizationsController < ApplicationController
  def index
    @organization_categories = OrganizationCategory.all
  end

  def show
    @organization = Organization.find params[:id]
    @booth_chairs = @organization.memberships.booth_chairs.all
    @members = @organization.participants.all
    @tools = Tool.checked_out_by_organization(@organization).just_tools.all
    @hardhats = Tool.checked_out_by_organization(@organization).hardhats.all
    @shifts = @organization.shifts.all
    @charges = @organization.charges.all
  end

  def edit
    @organization = Organization.find(params[:id])
  rescue
    flash[:error] = "Could not find org"
    redirect_to organizations_url
  end
end
