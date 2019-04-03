# ## Schema Information
#
# Table name: `charge_types`
#
# ### Columns
#
# Name                                 | Type               | Attributes
# ------------------------------------ | ------------------ | ---------------------------
# **`active`**                         | `boolean`          | `default(TRUE)`
# **`created_at`**                     | `datetime`         |
# **`default_amount`**                 | `decimal(8, 2)`    |
# **`description`**                    | `text(65535)`      |
# **`id`**                             | `integer`          | `not null, primary key`
# **`name`**                           | `string(255)`      |
# **`requires_booth_chair_approval`**  | `boolean`          |
# **`updated_at`**                     | `datetime`         |
#

class ChargeTypesController < ApplicationController
  load_and_authorize_resource

  # GET /charge_types
  # GET /charge_types.json
  def index
  end

  # GET /charge_types/new
  def new
  end

  #GET /charge_types/1
  def show
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => ActiveSupport::NumberHelper.number_to_currency(@charge_type.default_amount, unit: '', delimiter: '').to_json, :status => 200}
    end
  end

  # GET /charge_types/1/edit
  def edit
  end

  # POST /charge_types
  # POST /charge_types.json
  def create
    @charge_type.save
    if params[:from_charge].present?
      redirect_to new_charge_path
      return
    end
    redirect_to charge_types_path
  end

  # PATCH/PUT /charge_types/1
  # PATCH/PUT /charge_types/1.json
  def update
    @charge_type.update_attributes(charge_type_params)
    redirect_to charge_types_path
  end

  # DELETE /charge_types/1
  # DELETE /charge_types/1.json
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
      params.require(:charge_type).permit(:name, :default_amount, :description, :requires_booth_chair_approval)
    end
end
