class OrganizationStatusesController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_organization_status, only: [:show, :edit, :update, :destroy]
  before_action :set_organization
  
  # GET /organizations/1/statuses
  # GET /organizations/1/statuses.json
  def index
    @organization_statuses = @organization.organization_statuses #.paginate(:page => params[:page]).per_page(10)
  end

  # GET /organizations/1/statuses/1
  # GET /organizations/1/statuses/1.json
  def show
  end

  # GET /organizations/1/statuses/new
  # GET /organizations/1/statuses/new.json
  def new
    @organization_status = OrganizationStatus.new(:organization => @organization)
    respond_with @organization_status
  end

  # GET /organizations/1/statuses/1/edit
  def edit
  end

  # POST /organizations/1/statuses
  # POST /organizations/1/statuses.json
  def create
    @organization_status = OrganizationStatus.new(create_organization_status_params)
    @organization_status.participant = current_user.participant
    @organization_status.save
    respond_with @organization_status, location: -> { @organization_status.organization }
  end

  # PUT /organizations/1/statuses/1
  # PUT /organizations/1/statuses/1.json
  def update
    @organization_status.update(update_organization_status_params)
    respond_with @organization_status, location: -> { organization_organization_statuses_path(@organization_status.organization) }
  end

  # DELETE /organizations/1/statuses/1
  # DELETE /organizations/1/statuses/1.json
  def destroy
    @organization_status.destroy
    respond_with @organization_status, location: -> { organization_organization_statuses_path(@organization_status.organization) }
  end

  private
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_organization_status
    @organization_status = OrganizationStatus.find(params[:id])
  end 

  def create_organization_status_params
    params.require(:organization_status).permit(:organization_id, :organization_status_type_id, :description)
  end

  def update_organization_status_params
    params.require(:organization_status).permit(:description, :organization_status_type_id)
  end
end

