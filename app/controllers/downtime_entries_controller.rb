class DowntimeEntriesController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_downtime_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_organization

  # GET /downtime_entries
  # GET /downtime_entries.json
  def index
    @downtime_entries = @organization.downtime_entries.all
  end

  # GET /downtime_entries/1/edit
  def edit
  end

  # POST /downtime_entries
  # POST /downtime_entries.json
  def create
    @downtime_entry = DowntimeEntry.new(:starts_at => DateTime.now, :organization => @organization)

    respond_to do |format|
      if @downtime_entry.save
        format.html { redirect_to @organization, notice: 'Downtime entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @downtime_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /downtime_entries/1
  # PATCH/PUT /downtime_entries/1.json
  def update
    params = update_downtime_entry_params
  
    if (params[:ends_at].blank?)
      params[:ends_at] = DateTime.now
    end

    respond_to do |format|
      if @downtime_entry.update(params)
        format.html { redirect_to @downtime_entry, notice: 'Downtime entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @downtime_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /downtime_entries/1
  # DELETE /downtime_entries/1.json
  def destroy
    @downtime_entry.destroy
    respond_to do |format|
      format.html { redirect_to downtime_entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_downtime_entry
      @downtime_entry = DowntimeEntry.find(params[:id])
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_downtime_entry_params
      params.require(:downtime_entry).permit(:started_at, :ended_at)
    end
end
