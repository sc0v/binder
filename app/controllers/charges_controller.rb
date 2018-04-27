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
# **`description`**               | `text`             |
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

  def tool_to_charge
    unless ChargeType.where('name LIKE ?', 'Tool - Not returned').any?
      ChargeType.create!(default_amount: 0, description: "Participant did not checking tool within deadline", name: 'Tool - Not returned', requires_booth_chair_approval: true)
    end
    @charge_type = ChargeType.where('name LIKE ?', 'Tool - Not returned').first
    @checkouts = Checkout.where("checked_out_at IS NOT NULL AND checked_in_at IS NULL")
    if @checkouts.empty?
      redirect_to charges_path, notice: "All tools were checked in."
    else
      count = 0
      @checkouts.each do |checkout|
        t = checkout.tool
        Charge.create!(amount: 0,is_approved: false, charged_at: DateTime.now, description: t.description + "\n Checked out at " + checkout.checked_out_at.strftime("%F"), issuing_participant_id: current_user.participant.id, receiving_participant_id: checkout.participant_id, organization_id: checkout.organization_id,charge_type_id: @charge_type.id)
        count += 1
        Checkout.destroy(checkout)
        Tool.destroy(t)
      end
      redirect_to charges_path, notice: "Successfully added #{count} tools as charges."
    end

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
    @current_receiving_participant = @charge.receiving_participant.nil? ? "" : @charge.receiving_participant.formatted_name
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

