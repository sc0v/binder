class OrganizationBuildStatusesController < ApplicationController
  def show
    # is this necessary?
    @organization_build_status = OrganizationBuildStatus.find(params[:id])

    @organization = @organization_build_status.organization
    @status_type = @organization_build_status.status_type
    @status_name = @status_type.capitalize

    @organization_build_status.create_steps(booth_type: :two_story)
    @build_steps = @organization_build_status.organization_build_steps
  end
end
