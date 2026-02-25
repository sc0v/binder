# frozen_string_literal: true

require 'test_helper'

class DashboardPendingBuilderTest < ActiveSupport::TestCase
  fixtures :all

  def setup
    @builder = Dashboard::PendingBuilder.new
    @participant = participants(:scc_participant)
    @organization = organizations(:scc)
    @tool = Tool.find(1)
    @lift = scissor_lifts(:two)
  end

  test 'builds pending for all supported dashboard actions' do
    assert_pending_action({ 'kind' => 'checkin', 'tool_ids' => [@tool.id] }, 'checkin_tools_cart')
    assert_pending_action(checkout_flow, 'checkout_tools_cart')
    assert_pending_action(lift_forfeit_flow, 'forfeit_scissor_lift')
    assert_pending_action(lift_checkin_flow, 'checkin_scissor_lift')
    assert_pending_action(lift_renew_flow, 'renew_scissor_lift')
    assert_pending_action(lift_checkout_flow, 'checkout_scissor_lift')
    assert_pending_action(queue_add_flow, 'add_queue')
    assert_pending_action(queue_remove_flow, 'remove_queue')
  end

  private

  def assert_pending_action(flow, expected_action)
    result = @builder.call(flow)
    assert_nil result[:error], "unexpected error for #{expected_action}: #{result[:error]}"
    assert_equal expected_action, result.dig(:pending, 'action')
  end

  def checkout_flow
    {
      'kind' => 'checkout',
      'tool_ids' => [@tool.id],
      'participant_id' => @participant.id,
      'organization_id' => @organization.id
    }
  end

  def lift_forfeit_flow
    { 'kind' => 'lift', 'lift_action' => 'forfeit', 'scissor_lift_id' => @lift.id }
  end

  def lift_checkin_flow
    { 'kind' => 'lift', 'lift_action' => 'checkin', 'scissor_lift_id' => @lift.id }
  end

  def lift_renew_flow
    { 'kind' => 'lift', 'lift_action' => 'renew', 'scissor_lift_id' => @lift.id, 'hours' => 2 }
  end

  def lift_checkout_flow
    {
      'kind' => 'lift',
      'lift_action' => 'checkout',
      'scissor_lift_id' => @lift.id,
      'participant_id' => @participant.id,
      'organization_id' => @organization.id
    }
  end

  def queue_add_flow
    {
      'kind' => 'queue',
      'queue_type' => 'electrical',
      'queue_action' => 'add',
      'queue_source' => 'by_org',
      'organization_id' => @organization.id,
      'queue_message' => 'Need help with outlets'
    }
  end

  def queue_remove_flow
    {
      'kind' => 'queue',
      'queue_type' => 'electrical',
      'queue_action' => 'remove',
      'organization_id' => @organization.id
    }
  end
end
