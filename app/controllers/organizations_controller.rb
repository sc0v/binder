class OrganizationsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  
  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @charges = @organization.charges.last(10)
    @booth_chairs = @organization.booth_chairs
    @tools = Tool.checked_out_by_organization(@organization).just_tools.first(10)
    @shifts = @organization.shifts.future.first(10)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private
  
  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :organization_category_id)
  end
end

