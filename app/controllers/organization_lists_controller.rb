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

  # new organizion list
  def new
    # @document = OrganizationList.new
  end

  # no need for edit page


  def import
    OrganizationList.import(params[:org_name], params[:file])
    redirect_to organization_lists_path, notice: "Successfully added members to your organization!"
  end


# no need for update


# no need for destroy

  def destroy
    @organization_list.destroy
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
