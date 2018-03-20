class OrganizationListController < ApplicationController
  
  # Worry about authorization later
  
  load_and_authorize_resource skip_load_resource only: [:create] 

  # have an index page showing the pending memberships
  
  def index
    @members = OrganizationList.all
  end

  # no need for show page
  # def show
  #   @document = Document.find(params[:id])
  #   @document_url_path = @document.url.to_s
  # end


  # new organizion list
  def new
    @document = OrganizationList.new
  end

  # no need for edit page
  # def edit
  #   @document = Document.find(params[:id])
  # end


  # 
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

  # def update
  #   @document = Document.find(params[:id])

  #   if @document.update_attributes(update_document_params)
  #     flash[:notice] = "#{@document.name} was updated."
  #     redirect_to documents_path
  #   else
  #     render :action => 'edit'
  #   end
  # end


# no need for destroy

  # def destroy
  #   @document = Document.find(params[:id])
  #   @document.destroy

  #   flash[:notice] = "Successfully removed #{@document.name} from BOA."
  #   redirect_to documents_path
  # end

  private

  def organization_list_params
    params.require(:document).permit(:organization_name, :andrew_id)
  end

  
end
