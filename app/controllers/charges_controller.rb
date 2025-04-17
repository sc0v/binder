# frozen_string_literal: true
class ChargesController < ApplicationController
  include Exporter
  
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

    respond_to do |format|
      format.html
      format.json do
        data = Charge.all.as_json(methods: %i[charge_type_name organization_name organization_link])
        data.each do |d|
          charge = Charge.find(d['id'])
          d['show_link'] = helpers.link_to 'show', charge, class: 'btn'
          d['description_truncated'] = d['description'].truncate(85, separator: /\s/)
          #d['approve_link'] = link_to 'show', charge, class: 'btn'
        end
        render json: {data: }
      end
    end
  end

  def export
    headers = ['Charge Type', 'Description', 'Amount']
    generate_row = lambda { |charge| [charge.charge_type_name, charge.description, view_context.number_to_currency(charge.amount)] }
    csv_files = Hash.new

    Organization.all.each do |organization|
      org_charges = Charge.where(organization: organization)
      if org_charges.count > 0
        collection = Charge.where(organization: organization)
        footers = [nil, "Total", view_context.number_to_currency(org_charges.sum(:amount))]
        csv = Exporter.generate_csv(collection, headers, generate_row, footers)
        csv_files["#{organization.name} Invoice.csv"] = csv
      end
    end

    zip = Exporter.generate_zip(csv_files)
    respond_to do |format|
      format.zip do
          send_data zip, filename: "invoices.zip", type: 'application/zip'
      end
    end
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
    begin
      @charge.save!
    rescue
      flash.alert = "Could not create the charge: #{@charge.errors.full_messages}"
      redirect_to new_charge_path and return
    end
    redirect_to charge_path(@charge), notice: "Charge created!"
  end

  # PUT /charges/1
  # PUT /charges/1.json
  def update
    @charge.is_approved = false
    @charge.update(charge_params)
    redirect_to charge_path(@charge)
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    return redirect_to charges_path if @charge.blank?

    if @charge.charge_type == ChargeType.find_by(name: 'Store Purchase')
      charge_store_purchase = StorePurchase.find_by(charge_id: @charge.id)
      if charge_store_purchase.present?
        charge_store_purchase.destroy
      end
    end
    @charge.destroy
    redirect_to charges_path
  end

  # PUT
  def approve
    @charge.is_approved = !@charge.is_approved
    @charge.save

    if params[:url].present?
      redirect_to params[:url] and return
    end
    redirect_to charge_path(@charge) 
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
