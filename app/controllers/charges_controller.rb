# frozen_string_literal: true

class ChargesController < ApplicationController
  include Exporter

  load_and_authorize_resource

  before_action :set_charge, only: %i[show edit update destroy approve]

  def index
    if params[:organization_id].blank?
      @charges = Charge.all
    else
      @organization = Organization.find(params[:organization_id])
      @charges = @organization.charges
    end

    respond_to do |format|
      format.html
      format.json { render json: { data: charges_json_data } }
    end
  end

  # For each organization, generate a CSV including all charges and checked out
  # tools (since apparently that should be included in the invoice)
  def export
    zip = Exporter.generate_zip(build_invoice_csv_files)
    respond_to do |format|
      format.zip do
        send_data zip, filename: 'invoices.zip', type: 'application/zip'
      end
    end
  end

  def show
  end

  def new
    @charge = Charge.new
  end

  def edit
    @current_receiving_participant =
      @charge.receiving_participant&.formatted_name || ''
  end

  def create
    @charge = build_charge
    if @charge.save
      redirect_to charge_path(@charge), notice: t('.notice')
    else
      flash.alert =
        "Could not create the charge: #{@charge.errors.full_messages}"
      redirect_to new_charge_path
    end
  end

  def update
    @charge.is_approved = false
    @charge.update(charge_params)
    redirect_to charge_path(@charge)
  end

  def destroy
    return redirect_to charges_path if @charge.blank?

    if @charge.charge_type == ChargeType.find_by(name: 'Store Purchase')
      charge_store_purchase = StorePurchase.find_by(charge_id: @charge.id)
      charge_store_purchase.presence&.destroy
    end
    @charge.destroy
    redirect_to charges_path
  end

  def approve
    @charge.is_approved = !@charge.is_approved
    @charge.save

    return redirect_to params[:url] if params[:url].present?

    redirect_to charge_path(@charge)
  end

  private

  def set_charge
    @charge = Charge.find(params[:id])
  end

  def build_charge
    charge = Charge.new(charge_params)
    charge.charged_at = DateTime.now
    charge.creating_participant = Current.user
    charge.is_approved = false
    charge
  end

  def charge_params
    params.expect(
      charge: %i[
        amount
        description
        issuing_participant_id
        receiving_participant_id
        organization_id
        charge_type_id
      ]
    )
  end

  def charges_json_data
    data =
      Charge.all.as_json(
        methods: %i[charge_type_name organization_name organization_link]
      )
    data.each { |d| enrich_charge_json(d) }
  end

  def enrich_charge_json(row)
    charge = Charge.find(row['id'])
    row['show_link'] = helpers.link_to 'show', charge, class: 'btn'
    row['description_truncated'] = row['description'].truncate(
      85,
      separator: /\s/
    )
  end

  def build_invoice_csv_files
    {}.tap do |csv_files|
      Organization.find_each do |organization|
        csv = build_org_invoice_csv(organization)
        next if csv.empty?

        filename =
          ActiveStorage::Filename.new(
            "#{organization.name} Invoice.csv"
          ).sanitized
        csv_files[filename] = csv
      end
    end
  end

  def build_org_invoice_csv(organization)
    charge_csv = org_charge_csv(organization)
    tool_csv = org_tool_csv(organization)
    CSV.generate do |csv|
      if charge_csv
        CSV.parse(charge_csv).each { |row| csv << row }
        csv << []
      end
      CSV.parse(tool_csv).each { |row| csv << row } if tool_csv
    end
  end

  def org_charge_csv(organization)
    org_charges = Charge.where(organization:)
    return unless org_charges.any?

    headers = ['Charge Type', 'Description', 'Amount']
    generate_row =
      lambda do |charge|
        [
          charge.charge_type_name,
          charge.description,
          view_context.number_to_currency(charge.amount)
        ]
      end
    footers = [
      nil,
      'Total',
      view_context.number_to_currency(org_charges.sum(:amount))
    ]
    Exporter.generate_csv(org_charges, headers, generate_row, footers)
  end

  def org_tool_csv(organization)
    org_tools = Tool.checked_out_by_organization(organization)
    return unless org_tools.any?

    generate_row = ->(tool) { [tool.name, tool.barcode] }
    Exporter.generate_csv(org_tools, %w[Tool Barcode], generate_row, [])
  end
end
