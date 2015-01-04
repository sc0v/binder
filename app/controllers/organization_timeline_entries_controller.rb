class OrganizationTimelineEntriesController < ApplicationController
  authorize_resource
  before_action :set_organization_timeline_entry, only: [:update, :destroy, :end]

  def index
    @organization = Organization.find(params[:organization_id]) unless params[:organization_id].blank?

    @entries = OrganizationTimelineEntry.where({organization_timeline_entry_type_id: 3})

    @entries = @entries.where({organization: @organization}) unless @organization.blank?
  end

  # POST /organizations_timeline_entries
  # POST /organizations_timeline_entries.json
  def create
    @organization_timeline_entry = OrganizationTimelineEntry.new(organization_timeline_entry_params)
    @organization_timeline_entry.started_at = DateTime.now
    @organization_timeline_entry.organization_timeline_entry_type = case params[:commit]
      when 'Structural' then OrganizationTimelineEntryType.find_by_name("Structural Queue")
      when 'Electrical' then OrganizationTimelineEntryType.find_by_name("Electrical Queue")
      else OrganizationTimelineEntryType.find_by_name("Downtime")
    end

    respond_to do |format|
      if @organization_timeline_entry.save
        format.html { redirect_to URI.parse(params[:url]).path, notice: 'Organization Timeline Entry was successfully created.' }
        format.json { render json: @organization_timeline_entry, status: :created, location: @organization_timeline_entry.organization }
      else
        format.html { redirect_to root_url }
        format.json { render json: @organization_timeline_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations_timeline_entry/1
  # PUT /organizations_timeline_entry/1.json
  def update
    respond_to do |format|
      if @organization_timeline_entry.update_attributes(organization_timeline_entry_params)
        format.html { redirect_to @organization_timeline_entry, notice: 'Organization Timeline Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations_timeline_entry/1/end
  # PUT /organizations_timeline_entry/1/end.json
  def end
    respond_to do |format|
      @organization_timeline_entry.ended_at = DateTime.now
      
      if @organization_timeline_entry.save
        format.html { redirect_to URI.parse(params[:url]).path, notice: 'Organization Timeline Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations_timeline_entry/1
  # DELETE /organizations_timeline_entry/1.json
  def destroy
    @organization_timeline_entry.destroy

    respond_to do |format|
      format.html { redirect_to organization_timeline_entries_path }
      format.json { head :no_content }
    end
  end

  def electrical
    @organization_timeline_entries = OrganizationTimelineEntry.electrical.current
  end

  def structural
    @organization_timeline_entries = OrganizationTimelineEntry.structural.current
  end
  
  private
  
  def set_organization_timeline_entry
    @organization_timeline_entry = OrganizationTimelineEntry.find(params[:id])
  end

  def organization_timeline_entry_params
    params.require(:organization_timeline_entry).permit(:organization_id, :organization_timeline_entry_type_id, :description)
  end
end
