class OrganizationStatusTypesController < ApplicationController
  load_and_authorize_resource

  # GET /tool_types
  # GET /tool_types.json
  def index
  end

  # GET /tool_types/new
  def new
  end

  # GET /tool_types/1/edit
  def edit
  end

  # POST /tool_types
  # POST /tool_types.json
  def create
    @organization_status_type.save
    if params[:from_organization_status].present?
      redirect_to new_organization_status_path
      return
    end
    redirect_to organization_status_types_path
  end

  # PATCH/PUT /tool_types/1
  # PATCH/PUT /tool_types/1.json
  def update
    @organization_status_type.update_attributes(organization_status_type_params)
    redirect_to organization_status_types_path
  end

  # DELETE /tool_types/1
  # DELETE /tool_types/1.json
  def destroy
    if(@organization_status_type.organization_statuses.count > 0)
      flash[:error] = 'Cannot delete a status type until all organizations of that type are deleted.'
      redirect_to organization_status_types_url
      return
    end
    @organization_status_type.destroy
    respond_with(@organization_status_type)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_status_type_params
      params.require(:organization_status_type).permit(:name, :display)
    end
end
