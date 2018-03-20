class OrganizationListController < ApplicationController
  
  # Worry about authorization later
  
  # load_and_authorize_resource skip_load_resource only: [:create] 

  # have an index page showing the pending memberships
  
  def index
    @members = OrganizationList.all
  end

  # no need for show page

  # new organizion list
  def new
    # @document = OrganizationList.new
  end

  # no need for edit page


  def import
    User.import(params[:org_name], params[:file])
  end


# no need for update


# no need for destroy


  private

  # need to add security to the params 
  
  # def organization_list_params
  #   params.require(:organization_list).permit(:organization_name, :file)
  # end

  
end
