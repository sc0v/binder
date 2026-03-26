# frozen_string_literal: true

module ToolTableAttrs
  TABLE_ATTRS_JOINS = [
    'LEFT OUTER JOIN checkouts AS c ON (c.tool_id = tools.id AND c.checked_in_at IS NULL)',
    'LEFT OUTER JOIN (SELECT id, name AS org_name from organizations) AS o ON o.id = c.organization_id',
    'LEFT OUTER JOIN participants AS p ON p.id = c.participant_id'
  ].freeze
  TABLE_ATTRS_SELECT =
    'tools.*, tool_types.name AS t_name, o.org_name AS t_organization_name, ' \
      'c.checked_out_at IS NOT NULL AS t_is_checked_out, p.cached_name AS t_participant_name'

  def table_attrs
    TABLE_ATTRS_JOINS
      .reduce(joins(:tool_type)) { |scope, j| scope.joins(j) }
      .select(TABLE_ATTRS_SELECT)
  end
end
