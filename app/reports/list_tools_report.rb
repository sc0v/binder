class ListToolsReport < Dossier::Report

  def self.binder_report_info
    {
        title: "List all tools",
        description: "Lists the tools being tracked by binder.",
        params: [
          {name: :tool_type, type: :select,
           choices: [['All', 'all'], ['All except hardhats and radios', 'just_tools']] + ToolType.all.map{|o| [o.name, o.id]} },
          {name: :checkout_status, type: :select,
           choices: [['All', 'all'], ['Only Checked Out', 'checked_out'],
                     ['Only Checked In', 'checked_in']]},
        ]
    }
  end

  def sql
    # Limit by checkout status
    if options[:checkout_status] == 'checked_out'
      query = Tool.joins(:tool_type).checked_out
    elsif options[:checkout_status] == 'checked_in'
      query = Tool.joins(:tool_type).checked_in
    else
      query = Tool.joins(:tool_type)
    end

    # Limit by tool type
    if options[:tool_type] == 'just_tools'
      query = query.where("lower(name) NOT LIKE lower(?) AND lower(name) NOT LIKE lower(?)", "%radio", "%hardhat")
    elsif options[:tool_type] != 'all'
      query = query.where(tool_type: options[:tool_type])
    end

    query.select('tools.barcode AS \'Barcode\'', 'tool_types.name AS \'Type\'',
                 'tools.description AS \'Description\'',
                 'CASE WHEN EXISTS (SELECT checkouts.tool_id FROM checkouts WHERE checkouts.tool_id = tools.id AND checked_in_at IS NULL) THEN \'Yes\' ELSE \'No\' END AS \'Checked Out\'')
        .to_sql
  end
end