# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do
    @admin       = participants(:admin_participant)
    @participant = participants(:scc_participant)
    @org         = organizations(:scc)
    @tool        = Tool.find(1)          # barcode: 1
    @lift        = scissor_lifts(:two)   # Charizard
  end

  # ---------------------------------------------------------------------------
  # Authentication gating
  # ---------------------------------------------------------------------------

  test 'unauthenticated GET show redirects to login' do
    get dashboard_path
    assert_redirected_to login_url
  end

  test 'unauthenticated POST start redirects to login' do
    post dashboard_start_path, params: { kind: 'checkin' }
    assert_redirected_to login_url
  end

  test 'unauthenticated POST complete redirects to login' do
    post dashboard_complete_path
    assert_redirected_to login_url
  end

  # ---------------------------------------------------------------------------
  # Show
  # ---------------------------------------------------------------------------

  test 'authenticated show renders successfully' do
    sign_in_as @admin
    get dashboard_path
    assert_response :success
  end

  # ---------------------------------------------------------------------------
  # Start
  # ---------------------------------------------------------------------------

  test 'start with invalid kind redirects with alert' do
    sign_in_as @admin
    post dashboard_start_path, params: { kind: 'invalid_kind' }
    assert_redirected_to dashboard_path
    assert flash[:alert].present?
  end

  test 'start checkin redirects to dashboard with checkin flow params' do
    sign_in_as @admin
    post dashboard_start_path, params: { kind: 'checkin' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'kind=checkin'
  end

  test 'start checkout redirects to dashboard with checkout flow params' do
    sign_in_as @admin
    post dashboard_start_path, params: { kind: 'checkout' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'kind=checkout'
  end

  test 'start queue redirects to dashboard with queue flow params' do
    sign_in_as @admin
    post dashboard_start_path, params: { kind: 'queue' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'kind=queue'
  end

  test 'start lift redirects to dashboard with lift flow params' do
    sign_in_as @admin
    post dashboard_start_path, params: { kind: 'lift' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'kind=lift'
  end

  test 'start lookup redirects to dashboard with lookup flow params' do
    sign_in_as @admin
    post dashboard_start_path, params: { kind: 'lookup' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'kind=lookup'
  end

  # ---------------------------------------------------------------------------
  # Scan
  # ---------------------------------------------------------------------------

  test 'scan without flow params redirects with alert' do
    sign_in_as @admin
    post dashboard_scan_path, params: { scan_input: '1' }
    assert_redirected_to dashboard_path
    assert flash[:alert].present?
  end

  test 'scan tool barcode in checkin flow redirects back to dashboard' do
    sign_in_as @admin
    post dashboard_scan_path, params: {
      kind: 'checkin', step: 'tools',
      scan_input: @tool.barcode.to_s, target: 'tool'
    }
    assert_redirected_to %r{/dashboard}
  end

  test 'scan with blank input and no continue_to redirects with alert' do
    sign_in_as @admin
    post dashboard_scan_path, params: {
      kind: 'checkin', step: 'tools',
      scan_input: '', target: 'tool'
    }
    assert_redirected_to %r{/dashboard}
    assert flash[:alert].present?
  end

  # ---------------------------------------------------------------------------
  # Update
  # ---------------------------------------------------------------------------

  test 'update without flow params redirects with alert' do
    sign_in_as @admin
    post dashboard_update_path
    assert_redirected_to dashboard_path
    assert flash[:alert].present?
  end

  test 'update lift_action in lift flow advances the flow' do
    sign_in_as @admin
    post dashboard_update_path, params: {
      kind: 'lift', step: 'lift_action',
      lift_action: 'checkin'
    }
    assert_redirected_to %r{/dashboard}
  end

  # ---------------------------------------------------------------------------
  # Undo
  # ---------------------------------------------------------------------------

  test 'undo without flow params redirects to dashboard' do
    sign_in_as @admin
    post dashboard_undo_path
    assert_redirected_to dashboard_path
  end

  test 'undo in checkout flow at participant step goes back to tools' do
    sign_in_as @admin
    post dashboard_undo_path, params: { kind: 'checkout', step: 'participant', tool_ids: '1' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'step=tools'
  end

  test 'undo in lift flow at scissor_lift step goes back to lift_action' do
    sign_in_as @admin
    post dashboard_undo_path, params: { kind: 'lift', step: 'scissor_lift', lift_action: 'checkin' }
    assert_redirected_to %r{/dashboard}
    assert_includes response.location, 'step=lift_action'
  end

  # ---------------------------------------------------------------------------
  # Complete
  # ---------------------------------------------------------------------------

  test 'complete without flow params redirects with alert' do
    sign_in_as @admin
    post dashboard_complete_path
    assert_redirected_to dashboard_path
    assert flash[:alert].present?
  end

  test 'complete checkin flow with tools always redirects' do
    sign_in_as @admin
    # Tool has no active checkout so execution will fail, but should still redirect
    post dashboard_complete_path, params: { kind: 'checkin', step: 'tools', tool_ids: '1' }
    assert_response :redirect
  end

  test 'complete checkout flow without participant returns validation error' do
    sign_in_as @admin
    post dashboard_complete_path, params: {
      kind: 'checkout', step: 'organization', tool_ids: '1'
    }
    assert_redirected_to %r{/dashboard}
    assert flash[:alert].present?
  end

  test 'complete checkout flow without tools returns validation error' do
    sign_in_as @admin
    post dashboard_complete_path, params: {
      kind: 'checkout', step: 'organization',
      participant_id: @participant.id, organization_id: @org.id
    }
    assert_redirected_to %r{/dashboard}
    assert flash[:alert].present?
  end

  test 'complete lift checkin flow with scissor lift redirects' do
    sign_in_as @admin
    # Lift has no active checkout so execution will fail, but should still redirect
    post dashboard_complete_path, params: {
      kind: 'lift', step: 'scissor_lift',
      lift_action: 'checkin', scissor_lift_id: @lift.id
    }
    assert_response :redirect
  end

  test 'complete lookup flow is not executable and returns notice' do
    sign_in_as @admin
    post dashboard_complete_path, params: { kind: 'lookup', step: 'lookup' }
    assert_redirected_to %r{/dashboard}
  end

  # ---------------------------------------------------------------------------
  # Confirm
  # ---------------------------------------------------------------------------

  test 'GET confirm without pending_action param redirects with alert' do
    sign_in_as @admin
    get dashboard_confirm_path
    assert_redirected_to dashboard_path
    assert flash[:alert].present?
  end

  test 'GET confirm with pending_action renders successfully' do
    sign_in_as @admin
    get dashboard_confirm_path, params: {
      pending_action: 'checkin_scissor_lift',
      scissor_lift_id: @lift.id,
      kind: 'lift', step: 'scissor_lift', lift_action: 'checkin',
      requires_confirmation: 'true'
    }
    assert_response :success
  end

  # ---------------------------------------------------------------------------
  # Execute
  # ---------------------------------------------------------------------------

  test 'POST execute without pending_action param redirects with alert' do
    sign_in_as @admin
    post dashboard_execute_path
    assert_redirected_to dashboard_path
    assert flash[:alert].present?
  end

  test 'POST execute with pending action redirects' do
    sign_in_as @admin
    # Lift has no active checkout, execution will fail but response is still a redirect
    post dashboard_execute_path, params: {
      pending_action: 'checkin_scissor_lift',
      scissor_lift_id: @lift.id,
      requires_confirmation: 'true'
    }
    assert_response :redirect
  end

  # ---------------------------------------------------------------------------
  # Cancel
  # ---------------------------------------------------------------------------

  test 'POST cancel without flow returns to dashboard with notice' do
    sign_in_as @admin
    post dashboard_cancel_path
    assert_redirected_to dashboard_path
    assert flash[:notice].present?
  end

  test 'POST cancel with flow returns to previous step' do
    sign_in_as @admin
    post dashboard_cancel_path, params: {
      kind: 'checkout', step: 'organization', tool_ids: '1',
      participant_id: @participant.id
    }
    assert_redirected_to %r{/dashboard}
    assert flash[:notice].present?
  end

  # ---------------------------------------------------------------------------
  # Result
  # ---------------------------------------------------------------------------

  test 'GET result page renders successfully' do
    sign_in_as @admin
    get dashboard_result_path, params: { message: 'Checkout complete.' }
    assert_response :success
  end

  test 'GET result page with checked out and remaining ids renders successfully' do
    sign_in_as @admin
    get dashboard_result_path, params: {
      message: 'Partial checkout.',
      checked_out_ids: '1,2',
      remaining_ids: '3',
      participant_id: @participant.id,
      organization_id: @org.id
    }
    assert_response :success
  end
end
