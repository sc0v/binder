# frozen_string_literal: true

class OrganizationBuildStepsController < ApplicationController
  def show
    @build_step = OrganizationBuildStep.find(params[:id])
    @build_status = @build_step.organization_build_status
    @organization = @build_status.organization

    @status_name = @build_status.status_type.capitalize

    @requirements = OrganizationBuildStep.format_note(@build_step.requirements)
    @internal_notes =
      OrganizationBuildStep.format_note(@build_step.internal_notes)
  end

  def edit
    @build_step = OrganizationBuildStep.find(params[:id])
    @build_status = @build_step.organization_build_status
    @organization = @build_status.organization

    @status_name = @build_status.status_type.capitalize
  end

  def create
    @organization_build_status =
      OrganizationBuildStatus.find(params[:organization_build_status_id])
    @organization_build_step =
      @organization_build_status.organization_build_steps.new(
        build_step_create_params
      )
    if @organization_build_status.save
      redirect_to params[:url], notice: t('.notice')
    else
      redirect_to params[:url], alert: build_step_error_alert
    end
  end

  def update
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    case params[:update_type]
    when 'approved'
      handle_approved_update
    when 'enabled'
      handle_enabled_update
    else
      handle_field_update
    end
  end

  def destroy
    @organization_build_step = OrganizationBuildStep.find(params[:id])
    @organization_build_status =
      @organization_build_step.organization_build_status
    @organization_build_step.destroy
    redirect_to organizations_path(@organization_build_status),
                notice: t('.notice')
  end

  private

  def build_step_create_params
    {
      title: params[:organization_build_step][:title],
      requirements: params[:organization_build_step][:requirements],
      step: 0,
      is_enabled: true,
      approver: nil
    }
  end

  def update_params
    params.expect(
      organization_build_step: %i[requirements internal_notes is_enabled]
    )
  end

  def handle_approved_update
    toggle_build_step_approval
    @organization_build_step.save!
    redirect_to params[:url], notice: approval_notice
  end

  def toggle_build_step_approval
    if @organization_build_step.approver.nil?
      @organization_build_step.approver = Participant.find(params[:approver])
      @organization_build_step.approved_at = Time.zone.now
    else
      @organization_build_step.approver = nil
      @organization_build_step.approved_at = nil
    end
  end

  def approval_notice
    if @organization_build_step.approver.present?
      'Approved Checkoff!'
    else
      'Unapproved Checkoff!'
    end
  end

  def build_step_error_alert
    "Failed to Add Build Task! (#{@organization_build_step.errors.full_messages.join(',')})"
  end

  def handle_enabled_update
    @organization_build_step.is_enabled = !@organization_build_step.is_enabled
    @organization_build_step.save!
    redirect_to params[:url]
  end

  def handle_field_update
    @organization_build_step.update(update_params)
    redirect_to params[:url]
  end
end
