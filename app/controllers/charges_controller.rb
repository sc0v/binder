class ChargesController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_charge, only: [:show, :edit, :update, :destroy, :approve]
  responders :flash, :http_cache

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
    @charge.update(charge_params)
    respond_with(@charge)
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge.destroy
    respond_with(@charge)
  end
  
  # PUT
  def approve
    @charge.is_approved = !@charge.is_approved
    @charge.save
    respond_with @charge, location: -> {charges_path}
  end

  private
  def set_charge
    @charge = Charge.find(params[:id])
  end

  def charge_params
    params.require(:charge).permit(:amount, :description, :issuing_participant_id, :receiving_participant_id, :organization_id, :charge_type_id)
  end
end

