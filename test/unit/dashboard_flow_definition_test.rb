# frozen_string_literal: true

require 'test_helper'

class DashboardFlowDefinitionTest < ActiveSupport::TestCase
  test 'returns expected queue sequences by action context' do
    add_by_user = { 'kind' => 'queue', 'queue_action' => 'add', 'queue_source' => 'by_user' }
    add_by_org = { 'kind' => 'queue', 'queue_action' => 'add', 'queue_source' => 'by_org' }
    remove = { 'kind' => 'queue', 'queue_action' => 'remove' }

    assert_equal %w[queue_type queue_action queue_source participant organization queue_message], Dashboard::FlowDefinition.sequence(add_by_user)
    assert_equal %w[queue_type queue_action queue_source organization queue_message], Dashboard::FlowDefinition.sequence(add_by_org)
    assert_equal %w[queue_type queue_action organization], Dashboard::FlowDefinition.sequence(remove)
  end

  test 'terminal step detection covers each executable flow' do
    assert_not Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'checkin', 'step' => 'tools' })
    assert Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'checkout', 'step' => 'organization' })
    assert Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'lift', 'lift_action' => 'forfeit', 'step' => 'scissor_lift' })
    assert Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'lift', 'lift_action' => 'checkin', 'step' => 'scissor_lift' })
    assert Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'lift', 'lift_action' => 'renew', 'step' => 'renew_hours' })
    assert Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'lift', 'lift_action' => 'checkout', 'step' => 'organization' })
    assert_not Dashboard::FlowDefinition.terminal_step?({ 'kind' => 'queue', 'step' => 'organization' })
  end
end
