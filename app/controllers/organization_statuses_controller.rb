class OrganizationStatusesController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_organization_status, only: [:show, :edit, :update, :destroy]
  before_action :set_organization
  
  # GET /organizations/1/statuses
  # GET /organizations/1/statuses.json
  def index
    @organization_statuses = @organization.organization_statuses.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organization_statuses }
    end
  end

  # GET /organizations/1/statuses/1
  # GET /organizations/1/statuses/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/statuses/new
  # GET /organizations/1/statuses/new.json
  def new
    @organization_status = OrganizationStatus.new(:organization => @organization)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization_status }
    end
  end

  # GET /organizations/1/statuses/1/edit
  def edit
  end

  # POST /organizations/1/statuses
  # POST /organizations/1/statuses.json
  def create
    @organization_status = OrganizationStatus.new(create_organization_status_params)
    @organization_status.participant = current_user.participant

    respond_to do |format|
      if @organization_status.save
        format.html { redirect_to @organization_status.organization, notice: 'Organization Status was successfully created.' }
        format.json { render json: @organization_status, status: :created, location: @organization_staus.organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1/statuses/1
  # PUT /organizations/1/statuses/1.json
  def update
    respond_to do |format|
      if @organization.update(update_organization_status_params)
        format.html { redirect_to @organization, notice: 'Organization Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1/statuses/1
  # DELETE /organizations/1/statuses/1.json
  def destroy
    @organization_status.destroy

    respond_to do |format|
      format.html { redirect_to organization_organization_statuses_path(@organization) }
      format.json { head :no_content }
    end
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
    params.require(:organization_status).permit(:description)
  end
end

