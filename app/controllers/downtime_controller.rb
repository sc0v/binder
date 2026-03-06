# frozen_string_literal: true

class DowntimeController < ApplicationController
  # Controller for all downtime information for all organizations
  def downtime
    @organizations = Organization.all
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: t('.alert') unless Current.user.scc?
      end
      format.json { render json: building_downtime_map.as_json }
    end
  end

  # Controller for downtime information for a single organization
  def index
    @organization = Organization.find(params[:organization_id])
    @entries =
      OrganizationTimelineEntry.downtime.where({ organization: @organization })

    @is_on_downtime =
      OrganizationTimelineEntry
        .downtime
        .where({ organization: @organization })
        .current
        .present?
  end

  def toggle
    if params[:organization_id].blank?
      return redirect_to params[:url], alert: t('.blank_organization')
    end

    @organization = Organization.find(params[:organization_id])
    current_downtime =
      OrganizationTimelineEntry
        .downtime
        .where(organization: @organization)
        .current
    current_downtime.present? ? stop_downtime(current_downtime) : start_downtime
  end

  private

  def building_downtime_map
    Organization
      .select { |o| o.organization_category.building }
      .to_h { |org| [org.name, !org_on_downtime?(org)] }
  end

  def org_on_downtime?(org)
    OrganizationTimelineEntry.downtime.where(organization: org).current.present?
  end

  def stop_downtime(current_downtime)
    entry = current_downtime.first
    entry.ended_at = DateTime.now
    if entry.save
      redirect_to params[:url],
                  notice: "Stopped downtime for #{@organization.name}"
    else
      redirect_to params[:url],
                  alert: "Could not stop downtime for #{@organization.name}"
    end
  end

  def start_downtime
    downtime =
      OrganizationTimelineEntry.new(
        organization: @organization,
        entry_type: 'downtime',
        started_at: DateTime.now
      )
    if downtime.save
      redirect_to params[:url],
                  notice: "Started downtime for #{@organization.name}"
    else
      redirect_to params[:url], alert: start_downtime_error(downtime)
    end
  end

  def start_downtime_error(downtime)
    errors = downtime.errors.full_messages.join(', ')
    "Could not start downtime for #{@organization.name}: #{errors}"
  end
end
