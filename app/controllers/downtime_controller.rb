class DowntimeController < ApplicationController
  # Controller for all downtime information for all organizations
  def downtime
    @organizations = Organization.all
    # authorize! :read, @organizations
    respond_to do |format|
      format.html
      format.json do
        on_downtime_map = Hash.new
        Organization.all.each do |organization|
          on_downtime = OrganizationTimelineEntry.downtime.where(organization: organization).current.present?
          on_downtime_map[organization.name] = on_downtime
        end
        render json: on_downtime_map.as_json
      end
    end
  end

  # Controller for downtime information for a single organization
  def index
    @organization = Organization.find(params[:organization_id])
    @entries = OrganizationTimelineEntry.downtime.where({ organization: @organization })

    @is_on_downtime = OrganizationTimelineEntry.downtime.where({ organization: @organization }).current.present?
  end

  def toggle
    if params[:organization_id].blank?
      redirect_to params[:url], alert: "Must select an organization"
    end
    @organization = Organization.find(params[:organization_id])
    current_downtime = OrganizationTimelineEntry.downtime.where(organization: @organization).current
    if current_downtime.present?
      current_downtime.first.ended_at = DateTime.now
      if current_downtime.first.save
        redirect_to params[:url], notice: "Stopped downtime for #{@organization.name}" and return
      else 
        redirect_to params[:url], alert: "Could not stop downtime for #{@organization.name}" and return
      end
    else
      downtime = OrganizationTimelineEntry.new({
        organization: @organization,
        entry_type: 'downtime',
        started_at: DateTime.now,
      })
      if downtime.save
        redirect_to params[:url], notice: "Started downtime for #{@organization.name}"
      else
        redirect_to params[:url], alert: "Could not start downtime for #{@organization.name}: #{downtime.errors.full_messages.join(', ')}"
      end
    end
  end
end
