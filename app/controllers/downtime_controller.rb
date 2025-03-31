class DowntimeController < ApplicationController
  # Controller for all downtime information for all organizations
  def downtime
    @organizations = Organization.all
    # authorize! :read, @organizations
    respond_to do |format|
      format.html do
        # TODO: This should be done using CanCanCan, but this is difficult because
        # booth chairs can manage queues but not downtime (which are both done
        # with the OrganizationTimelineEntry model) 
        unless Current.user.scc? 
          redirect_to root_path, alert: "Cannot Access Downtime!"
        end
      end
      format.json do
        on_downtime_map = Hash.new
        @building_orgs = Organization.select { |o| o.organization_category.building }
        @building_orgs.each do |organization|
          on_downtime = OrganizationTimelineEntry.downtime.where(organization: organization).current.present?
          on_downtime_map[organization.name] = !on_downtime
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
