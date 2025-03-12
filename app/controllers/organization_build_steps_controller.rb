class OrganizationBuildStepsController < ApplicationController
  def create
      @organization_build_status = OrganizationBuildStatus.find(params[:organization_build_status_id])
      @organization_build_status.organization_build_steps.new(
        title: params[:organization_build_step][:title],
        requirements: params[:organization_build_step][:requirements],
        step: 0,
        is_enabled: true,
        approver: nil)

      if @organization_build_status.save()
        redirect_to params[:url], notice: 'Added Build Task!'
      else
        redirect_to params[:url], alert: ('Failed to Add Build Task! (' + @organization_build_step.errors.full_messages.join(",") + ")")
      end
  end

  def destroy
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    @organization_build_status = @organization_build_step.organization_build_status
    @organization_build_step.destroy
    redirect_to organizations_path(@organization_build_status), notice: 'Destroyed Build Task!'
  end

  def show
    @build_step = OrganizationBuildStep.find(params[:id])
    @build_status = @build_step.organization_build_status
    @organization = @build_status.organization

    @status_name = @build_status.status_type.capitalize
    
    @requirements = OrganizationBuildStep.format_note(@build_step.requirements)
    @internal_notes = OrganizationBuildStep.format_note(@build_step.internal_notes)
  end

  def edit
    @build_step = OrganizationBuildStep.find(params[:id])
    @build_status = @build_step.organization_build_status
    @organization = @build_status.organization

    @status_name = @build_status.status_type.capitalize
  end

  def update
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    if params[:update_type] == "approved"
      if @organization_build_step.approver.nil?
        @organization_build_step.approver = Participant.find(params[:approver])
        @organization_build_step.approved_at = Time.zone.now
      else
        @organization_build_step.approver = nil
        @organization_build_step.approved_at = nil
      end
      
      if @organization_build_step.save!
        if @organization_build_step.approver.present?
          notice = "Approved Checkoff!"
        else
          notice = "Unapproved Checkoff!"
        end
        redirect_to params[:url], notice: notice and return
      end
    elsif params[:update_type] == "enabled"
      @organization_build_step.is_enabled = !@organization_build_step.is_enabled
      @organization_build_step.save!
      redirect_to params[:url] and return
    else 
      @organization_build_step.update(update_params)
      redirect_to params[:url] and return
    end
    # TODO: Figure out flash with turbo
    flash.now[:alert] = "type shit"
    redirect_to params[:url]
  end

  private

  def update_params
    params.require(:organization_build_step).permit(:requirements, :internal_notes, :is_enabled)
  end
end

