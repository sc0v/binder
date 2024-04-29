class OrganizationBuildStepsController < ApplicationController
  def create
      @organization_build_status = OrganizationBuildStatus.find(params[:organization_build_status_id])
      @organization_build_status.organization_build_steps.new(
        title: params[:organization_build_step][:title],
        requirements: params[:organization_build_step][:requirements],
        step: 0,
        completed: false)

      if @organization_build_status.save!
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

  def show
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    @organization_build_status = @organization_build_step.organization_build_status
    @organization = @organization_build_status.organization

    @status_type = @organization_build_status.status_type
    @status_name = @status_type.capitalize

    @requirements = @organization_build_step.requirements
    @completed = @organization_build_step.completed
  end

  def update
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    if params[:update_type] == "approved"
      @organization_build_step.completed = !@organization_build_step.completed
      
      if @organization_build_step.save()
        if @organization_build_step.completed
          notice = "Approved Checkoff!"
        else
          notice = "Unapproved Checkoff!"
        end
        redirect_to params[:url], notice: notice and return
      end
    end
    redirect_to params[:url], alert: 'Update Failed!'
  end
end
