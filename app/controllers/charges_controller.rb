class ChargesController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
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

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charges }
    end
  end

  def export
    @charges = Charge.all
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @charge }
    end
  end

  # GET /charges/new
  # GET /charges/new.json
  def new
    @charge = Charge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charge }
    end
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

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render json: @charge, status: :created, location: @charge }
      else
        format.html { render action: "new" }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charges/1
  # PUT /charges/1.json
  def update
    @charge.is_approved = false

    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge.destroy

    respond_to do |format|
      format.html { redirect_to charges_url }
      format.json { head :no_content }
    end
  end
  
  # PUT
  def approve
    @charge.is_approved = !@charge.is_approved
    
    url = charges_path
    url = params[:url] unless params[:url].blank?
    
    respond_to do |format|
      if @charge.save
        format.html { redirect_to URI.parse(params[:url]).path, notice: 'Charge was successfully approved.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_charge
    @charge = Charge.find(params[:id])
  end

  def charge_params
    params.require(:charge).permit(:amount, :description, :issuing_participant_id, :receiving_participant_id, :organization_id, :charge_type_id)
  end
end

