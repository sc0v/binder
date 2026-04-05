# frozen_string_literal: true

class OrganizationBuildStatusesController < ApplicationController
  def index
    authorize! :manage, OrganizationBuildStatus
    @type = params[:type].presence_in(%w[structural electrical]) || 'structural'
    @statuses = load_statuses
    @step_titles = build_step_titles(@statuses)
    @step_lookup = build_step_lookup(@statuses)
  end

  def show
    @build_status = OrganizationBuildStatus.find(params[:id])

    @organization = @build_status.organization
    @status_type = @build_status.status_type
    @status_name = @status_type.capitalize

    @build_steps = @build_status.organization_build_steps.order(:step)
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
    params.expect(organization_build_status: [:notes])
  end

  def load_statuses
    OrganizationBuildStatus
      .where(status_type: @type)
      .where(enabled_steps_exist)
      .includes(organization: {}, organization_build_steps: :approver)
      .joins(:organization)
      .order('organizations.name')
  end

  def enabled_steps_exist
    OrganizationBuildStep
      .where(
        'organization_build_steps.organization_build_status_id = organization_build_statuses.id'
      )
      .where(is_enabled: true)
      .select('1')
      .arel
      .exists
  end

  def build_step_titles(statuses)
    statuses
      .flat_map do |s|
        s.organization_build_steps.select(&:is_enabled).map(&:title)
      end
      .uniq
  end

  def build_step_lookup(statuses)
    statuses.each_with_object({}) do |status, hash|
      hash[status.id] = status
        .organization_build_steps
        .select(&:is_enabled)
        .group_by(&:title)
        .transform_values(&:first)
    end
  end
end
