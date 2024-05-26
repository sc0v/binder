# frozen_string_literal: true
class ChargesController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_charge, only: %i[show edit update destroy approve]

  # GET /charges
  # GET /charges.json
  def index
    if params[:organization_id].blank?
      @charges = Charge.all
    else
      @organization = Organization.find(params[:organization_id])
      @charges = @organization.charges
    end

    # @charges = @charges.paginate(:page => params[:page]).per_page(20)
  end

  def export
    @charges = Charge.all
  end

  # GET /charges/1
  # GET /charges/1.json
  def show; end

  # GET /charges/new
  # GET /charges/new.json
  def new
    @charge = Charge.new
  end

  # GET /charges/1/edit
  def edit
    @current_receiving_participant = @charge.receiving_participant.nil? ? '' : @charge.receiving_participant.formatted_name
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new(charge_params)
    @charge.charged_at = DateTime.now
    @charge.creating_participant = Current.user
    @charge.is_approved = false
    @charge.save!
    respond_with @charge
  end

  # PUT /charges/1
  # PUT /charges/1.json
  def update
    @charge.is_approved = false
    @charge.update(charge_params)
    respond_with(@charge)
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    return redirect_to :back if @charge.blank?

    if @charge.charge_type == ChargeType.find_by(name: 'Store Purchase')
      charge_store_purchase = StorePurchase.find_by(charge_id: @charge.id)
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
    params.require(:charge).permit(:amount, :description, :issuing_participant_id, :receiving_participant_id,
                                   :organization_id, :charge_type_id)
  end
end
