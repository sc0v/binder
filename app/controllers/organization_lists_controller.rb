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
  
  before_action :set_organization_list, only: [:destroy]


  # have an index page showing the pending memberships
  
  def index
    @user = current_user
    @members = OrganizationList.all
    @user.participant.memberships.each do |membership|
      if membership.is_booth_chair?
        @org_id = membership.organization_id
        @org_name = membership.organization.name
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
        redirect_to organization_lists_path, alert: "No AndrewID entered!"
    else
      OrganizationList.add(params[:org_name], params[:andrew_id])
      redirect_to organization_lists_path, notice: "Successfully added "+ params[:andrew_id] + " to " + Organization.find(params[:org_name]).name
    end
  end

  # no need for edit page


  def import
    if params[:file].nil?
        redirect_to organization_lists_path, alert: "No CSV file chosen!"
    else
      count = OrganizationList.import(params[:org_name], params[:file])
      redirect_to organization_lists_path, notice: "Successfully added " + count.to_s + " members to " + Organization.find(params[:org_name]).name
    end
  end


# no need for update


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

end
