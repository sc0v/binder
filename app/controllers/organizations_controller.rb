class OrganizationsController < ApplicationController
  load_and_authorize_resource
  
  # GET /organizations
  # GET /organizations.json
  def index
    if (params[:type] == "building")
      @organizations = @organizations.only_categories(['Fraternity', 'Sorority', 'Independent', 'Blitz', 'Concessions'])
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @charges = @organization.charges.last(10)
    @booth_chairs = @organization.booth_chairs
    @tools = Tool.checked_out_by_organization(@organization).just_tools.first(10)
    @shifts = @organization.shifts.future.first(10)
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization.save
    respond_with(@organization)
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization.update(organization_params)
    respond_with(@organization)
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_with(@organization)
  end
  
  def hardhats
    @hardhats = Tool.checked_out_by_organization(@organization).hardhats
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :short_name, :organization_category_id)
  end
end

