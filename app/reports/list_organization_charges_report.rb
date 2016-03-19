class ListOrganizationChargesReport < Dossier::Report

  def self.binder_report_info
    {
        title: "List organization charges",
        description: "Lists the charges for an organization. You may choose to include either
                      store charges, fines, or both. You can choose to show charges for one organization or all
                      of them. You will need to sum total values manually in Excel (by downloading the CSV).",
        params: [
          {name: :organization, type: :select, choices: [['All', 'all']] + Organization.all.map{|o| [o.name, o.id]} },
          {name: :include_charge_types, type: :select,
           choices: [['All charges', 'all'], ['Only Store Purchases', 'store_only'],
                     ['Only Non-Store Purchases', 'non_store_only']]},
          {name: :include_pending_charges, type: :checkbox}
        ]
    }
  end

  def format_Approved(value)
    return "Yes" if value.to_s.strip == '1'
    "No"
  end

  def sql
    query = Charge.joins(:organization, :charge_type, :issuing_participant,
                         :receiving_participant, :creating_participant)
                .reorder('organizations.name, charges.charged_at')

    # Limit by organization
    unless options[:organization] == 'all'
      query = query.where(organization: options[:organization])
    end

    # Limit by charge type
    if options[:include_charge_types] == 'non_store_only'
      query = query.where.not(charge_types: {name: 'Store Purchase'})
    elsif options[:include_charge_types] == 'store_only'
      query = query.where(charge_types: {name: 'Store Purchase'})
    end

    # Optionally show pending charges
    unless options[:include_pending_charges]
      query = query.approved
    end

    query.select('organizations.name AS \'Organization\'', 'charges.amount AS \'Amount\'',
                 'charge_types.name AS \'Charge Type\'', 'charges.charged_at AS \'Charged At\'',
                 'charges.is_approved AS \'Approved\'',
                 'creating_participants_charges.andrewid AS \'Creator\'',
                 'participants.andrewid AS \'Issuer\'',
                 'receiving_participants_charges.andrewid AS \'Receiver\'',
                 'charges.description AS \'Description\'').to_sql
  end
end