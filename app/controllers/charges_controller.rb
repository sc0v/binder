# ## Schema Information
#
# Table name: `charges`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`amount`**                    | `decimal(8, 2)`    |
# **`charge_type_id`**            | `integer`          |
# **`charged_at`**                | `datetime`         |
# **`created_at`**                | `datetime`         |
# **`creating_participant_id`**   | `integer`          |
# **`description`**               | `text(65535)`      |
# **`id`**                        | `integer`          | `not null, primary key`
# **`is_approved`**               | `boolean`          |
# **`issuing_participant_id`**    | `integer`          |
# **`organization_id`**           | `integer`          |
# **`receiving_participant_id`**  | `integer`          |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_charges_on_organization_id`:
#     * **`organization_id`**
#

class ChargesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_charge, only: [:show, :edit, :update, :destroy, :approve]

  # GET /charges
  # GET /charges.json
  def index
    unless ( params[:organization_id].blank? )
      @organization = Organization.find(params[:organization_id])
      @charges = @organization.charges
    else
      @charges = Charge.all
    end

    @charges = @charges.paginate(:page => params[:page]).per_page(20)
  end

  def export
    @charges = Charge.all
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
  end

  # GET /charges/new
  # GET /charges/new.json
  def new
    @charge = Charge.new
  end

  # GET /charges/1/edit
  def edit
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new(charge_params)
    @charge.charged_at = DateTime.now
    @charge.creating_participant = current_user.participant
    @charge.is_approved = false
    @charge.save
    respond_with @charge
  end

  # PUT /charges/1
  # PUT /charges/1.json
  def update
    @charge.is_approved = false
    @charge.update_attributes(charge_params)
    respond_with(@charge)
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    return redirect_to :back unless @charge.present?
    if @charge.charge_type == ChargeType.find_by_name('Store Purchase')
      charge_store_purchase = StorePurchase.find_by_charge_id(@charge.id)
      charge_store_purchase.destroy
    end
    @charge.destroy
    respond_with(@charge)
  end
  
  # PUT
  def approve
    @charge.is_approved = !@charge.is_approved
    @charge.save

    respond_with(@charge, location: @charge.organization)
  end

  private
  def set_charge
    @charge = Charge.find(params[:id])
  end

  def charge_params
    params.require(:charge).permit(:amount, :description, :issuing_participant_id, :receiving_participant_id, :organization_id, :charge_type_id)
  end
end

