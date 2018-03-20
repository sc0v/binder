class OrganizationListController < ApplicationController
  
  # Worry about authorization later
  
  load_and_authorize_resource skip_load_resource only: [:create] 

  # have an index page showing the pending memberships
  
  def index
    @members = OrganizationList.all
  end

  # no need for show page

  # new organizion list
  def new
    @document = OrganizationList.new
  end

  # no need for edit page


  # need to
  def create
    
    @organization_list = OrganizationList.new(organization_list_params)

    if @organization_list.save
      flash[:notice] = "Organization list has been uploaded."
      redirect_to organization_list_path
    else
      render :action => 'new'
    end
  end


# no need for update


# no need for destroy


  private

  def organization_list_params
    params.require(:organization_list).permit(:organization_name, :andrew_id)
  end

  
end
