# ## Schema Information
#
# Table name: `organization_lists`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`andrew_id`**        | `string`           |
# **`created_at`**       | `datetime`         | `not null`
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`updated_at`**       | `datetime`         | `not null`
#

class OrganizationListsController < ApplicationController
  
  # Worry about authorization later
  
  # load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_organization_list, only: [:destroy]


  # have an index page showing the pending memberships
  
  def index
    @user = current_user
    @members = OrganizationList.all
    @user.participant.memberships.each do |membership|
      if membership.is_booth_chair?
        @org_id = membership.organization_id
        @org_name = membership.organization.name
        # @org_name = @org_name.slice(0, @org_name.length-14)
      end
    end

  end

  # no need for show page

  # new organization list
  def new
  end

  # new organization list
  def add
    if params[:andrew_id].empty?
        redirect_to organization_lists_path, alert: "No andrew ID entered!"
    else
      OrganizationList.add(params[:org_name], params[:andrew_id])
      redirect_to organization_lists_path, notice: "Successfully added this member to the organization!"
    end
  end

  # no need for edit page


  def import
    if params[:file].nil?
        redirect_to organization_lists_path, alert: "No CSV file chosen!"
    else
      OrganizationList.import(params[:org_name], params[:file])
      redirect_to organization_lists_path, notice: "Successfully added members to the organization!"
    end
  end


# no need for update


# no need for destroy

  def destroy
    @organization_list.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to(organizations_url) }

    end
  end


  private
  
  def set_organization_list
    @organization_list = OrganizationList.find(params[:id])
  end

  # need to add security to the params 
  
  # def organization_list_params
  #   params.require(:organization_list).permit(:organization_name, :file)
  # end

  
end
