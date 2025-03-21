class OrganizationBuildStatusesController < ApplicationController
  def show
    @build_status = OrganizationBuildStatus.find(params[:id])

    @organization = @build_status.organization
    @status_type = @build_status.status_type
    @status_name = @status_type.capitalize

    @build_steps = @build_status.organization_build_steps
    @show_disabled_steps = params[:show_disabled_steps].present?

    @notes = OrganizationBuildStep.format_note(@build_status.notes)
  end

  def edit
    @build_status = OrganizationBuildStatus.find(params[:id])
    @organization = @build_status.organization

    @notes = OrganizationBuildStep.format_note(@build_status.notes)
  end

  def update
    @build_status = OrganizationBuildStatus.find(params[:id])
    @build_status.update(update_params)
    redirect_to params[:url] and return
  end

  private

  def update_params
    params.require(:organization_build_status).permit(:notes)
  end
end

