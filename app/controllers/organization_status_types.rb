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
    @charge_type.save
    if params[:from_charge].present?
      redirect_to new_charge_path
      return
    end
    redirect_to charge_types_path
  end

  # PATCH/PUT /tool_types/1
  # PATCH/PUT /tool_types/1.json
  def update
    @charge_type.update_attributes(charge_type_params)
    redirect_to charge_types_path
  end

  # DELETE /tool_types/1
  # DELETE /tool_types/1.json
  def destroy
    if(@charge_type.charges.count > 0)
      flash[:error] = 'Cannot delete a charge type until all charges of that type are deleted.'
      redirect_to charge_types_url
      return
    end
    @charge_type.destroy
    respond_with(@charge_type)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_type_params
      params.require(:charge_type).permit(:name)
    end
end
