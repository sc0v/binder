class OrganizationBuildStepsController < ApplicationController
  def create
      @organization_build_status = OrganizationBuildStatus.find(params[:organization_build_status_id])
      @organization_build_status.organization_build_steps.create(
        title: params[:organization_build_step][:title],
        requirements: params[:organization_build_step][:requirements],
        step: 0,
        completed: false)

      if @organization_build_status.save() then
        redirect_to params[:url], notice: 'Added Build Task!'
      else
        redirect_to params[:url], alert: ('Failed to Add Build Task! (' + @organization_build_step.errors.full_messages.join(",") + ")")
      end
  end

  def destroy
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    @organization_build_status = @organization_build_step.organization_build_status
    @organization_build_step.destroy
    #this doesn't seem like it should work, yet it does...
    redirect_to organizations_path(@organization_build_status), notice: 'Destroyed Build Task!'
  end
end
