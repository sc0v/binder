# ## Schema Information
#
# Table name: `organizations`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`created_at`**                | `datetime`         |
# **`id`**                        | `integer`          | `not null, primary key`
# **`name`**                      | `string(255)`      |
# **`organization_category_id`**  | `integer`          |
# **`short_name`**                | `string(255)`      |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_organizations_on_organization_category_id`:
#     * **`organization_category_id`**
#

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
    @booth_chairs = @organization.booth_chairs
    @tools = Tool.checked_out_by_organization(@organization).just_tools
    @shifts = @organization.shifts
    @user = current_user
    @user.participant.memberships.each do |membership|
      if membership.is_booth_chair?
        @org_id = membership.organization_id
      end
    end
    if is_admin?
      @org_id = Organization.find(params[:id])
    end
    @pending_memberships = OrganizationList.where(organization_id: @org_id)
    
    @participants = @organization.participants
    @documents = @organization.documents
    @charges = @organization.charges
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

