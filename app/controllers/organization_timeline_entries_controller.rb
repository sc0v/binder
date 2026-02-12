# frozen_string_literal: true
class OrganizationTimelineEntriesController < ApplicationController
  load_and_authorize_resource
  #authorize_resource
  before_action :set_organization_timeline_entry, only: %i[update destroy end show]

  def show
    @organization_timeline_entry = OrganizationTimelineEntry.find(params[:id])
  end

  def edit
    @organization_timeline_entry = OrganizationTimelineEntry.find(params[:id])
  end

  # POST /organizations_timeline_entries
  # POST /organizations_timeline_entries.json
  def create
    commit_entry_types = {
      'Structural' => 'structural',
      'Electrical' => 'electrical',
      'Scissor Lift' => 'scissor_lift',
    }.freeze

    unless commit_entry_types.key?(params[:commit])
      redirect_to params[:url], alert: 'Select a queue type to continue.'
      return
    end

    @organization_timeline_entry = OrganizationTimelineEntry.new(organization_timeline_entry_params)
    @organization_timeline_entry.started_at = Time.now
    @organization_timeline_entry.entry_type = commit_entry_types.fetch(params[:commit])

    if @organization_timeline_entry.already_in_queue?
      redirect_to params[:url], alert: "You're already on the queue!"

    elsif @organization_timeline_entry.save
      if @organization_timeline_entry.entry_type == 'structural'
        redirect_to params[:url], notice: "Added to structural queue!"
      elsif @organization_timeline_entry.entry_type == 'electrical'
        redirect_to params[:url], notice: "Added to electrical queue!"
      else
        redirect_to params[:url], notice: "Started downtime!"
      end
    else
      redirect_to params[:url], alert: t(".alert")
    end
  end

  # PUT /organizations_timeline_entry/1
  # PUT /organizations_timeline_entry/1.json
  def update
    @organization_timeline_entry.update(organization_timeline_entry_params)
    redirect_to organization_downtime_index_path(@organization_timeline_entry.organization)
  end

  # PUT /organizations_timeline_entry/1/end
  # PUT /organizations_timeline_entry/1/end.json
  def end
    authorize! :end, @organization_timeline_entry

    @organization_timeline_entry.ended_at = DateTime.now
    @organization_timeline_entry.save
    redirect_to params[:url], notice: 'Removed from Queue!'
  end

  # DELETE /organizations_timeline_entry/1
  # DELETE /organizations_timeline_entry/1.json
  def destroy
    @organization_timeline_entry = OrganizationTimelineEntry.find(params[:id])
    @organization_timeline_entry.destroy
    flash[:notice] = 'Successfully removed entry from downtime tracker'
    redirect_to organization_downtime_index_path(@organization_timeline_entry.organization)
  end

  def electrical
    @organization_timeline_entries = OrganizationTimelineEntry.electrical.current
  end

  def structural
    @organization_timeline_entries = OrganizationTimelineEntry.structural.current
  end

  def queues
    @electrical = OrganizationTimelineEntry.electrical.current
    @structural = OrganizationTimelineEntry.structural.current
  end

  private

  def set_organization_timeline_entry
    @organization_timeline_entry = OrganizationTimelineEntry.find(params[:id])
  end

  def organization_timeline_entry_params
    params.require(:organization_timeline_entry).permit(:organization_id, :ended_at, :started_at,
                                                        :description)
  end
end
