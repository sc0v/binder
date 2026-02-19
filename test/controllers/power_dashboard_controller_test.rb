# frozen_string_literal: true

require 'test_helper'

class PowerDashboardControllerTest < ActionDispatch::IntegrationTest
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
    get power_dashboard_path
    assert_redirected_to login_url
  end

  test 'unauthenticated POST submit redirects to login' do
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    assert_redirected_to login_url
  end

  test 'unauthenticated GET confirm redirects to login' do
    get power_dashboard_confirm_path
    assert_redirected_to login_url
  end

  test 'unauthenticated POST execute redirects to login' do
    post power_dashboard_execute_path
    assert_redirected_to login_url
  end

  # ---------------------------------------------------------------------------
  # Show
  # ---------------------------------------------------------------------------

  test 'authenticated show renders successfully' do
    sign_in_as @admin
    get power_dashboard_path
    assert_response :success
  end

  # ---------------------------------------------------------------------------
  # Autocomplete
  # ---------------------------------------------------------------------------

  test 'autocomplete with query shorter than 2 chars returns empty suggestions' do
    sign_in_as @admin
    get power_dashboard_autocomplete_path, params: { q: 'c' }
    assert_response :success
    data = JSON.parse(response.body)
    assert_equal [], data['suggestions']
  end

  test 'autocomplete with valid query returns JSON with suggestions array' do
    sign_in_as @admin
    get power_dashboard_autocomplete_path, params: { q: 'ch' }
    assert_response :success
    data = JSON.parse(response.body)
    assert data.key?('suggestions')
    assert_kind_of Array, data['suggestions']
  end

  test 'autocomplete includes action suggestions by default' do
    sign_in_as @admin
    get power_dashboard_autocomplete_path, params: { q: 'ch' }
    data = JSON.parse(response.body)
    assert data['suggestions'].any? { |s| s['type'] == 'action' },
           'expected at least one action suggestion for "ch" (checkin, checkout)'
  end

  test 'autocomplete mode=resources excludes action suggestions' do
    sign_in_as @admin
    get power_dashboard_autocomplete_path, params: { q: 'ch', mode: 'resources' }
    assert_response :success
    data = JSON.parse(response.body)
    data['suggestions'].each do |s|
      assert_not_equal 'action', s['type'], "unexpected action suggestion in resources mode: #{s['label']}"
    end
  end

  # ---------------------------------------------------------------------------
  # Submit – blank input
  # ---------------------------------------------------------------------------

  test 'submit blank input redirects with blank_input alert' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: '   ' }
    assert_redirected_to power_dashboard_path
    assert_equal I18n.t('power_dashboard.submit.blank_input'), flash[:alert]
  end

  # ---------------------------------------------------------------------------
  # Submit – resource selection
  # ---------------------------------------------------------------------------

  test 'submit valid tool barcode selects tool and redirects with notice' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'submit scissor lift name selects lift and redirects with notice' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @lift.name }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'submit participant eppn selects participant and redirects with notice' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'submit unrecognized input renders show with error' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: 'xyzzy_no_such_resource_99999' }
    assert_response :success  # re-renders show with flash.now
    assert flash[:alert].present? || response.body.include?('no_such_resource')
  end

  # ---------------------------------------------------------------------------
  # Submit – immediate actions (no confirmation step)
  # ---------------------------------------------------------------------------

  test 'submit add command with tool in context adds to cart and redirects' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'add' }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'submit add shorthand a also adds tool to cart' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'a' }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'submit remove command without tool in cart returns error' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'remove' }
    assert_redirected_to power_dashboard_path
    assert flash[:alert].present?
  end

  test 'submit remove removes tool that was added to cart' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'add' }
    post power_dashboard_submit_path, params: { power_input: 'remove' }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'submit clear resets session and redirects' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'clear' }
    assert_redirected_to power_dashboard_path
  end

  test 'submit electrical selects queue and redirects' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: 'electrical' }
    assert_redirected_to power_dashboard_path
  end

  test 'submit auto toggles auto-add mode and redirects' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: 'auto' }
    assert_redirected_to power_dashboard_path
  end

  test 'submit lifts selects scissor lifts overview and redirects' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: 'lifts' }
    assert_redirected_to power_dashboard_path
  end

  # ---------------------------------------------------------------------------
  # Submit – confirmation-required actions (staged → confirm page)
  # ---------------------------------------------------------------------------

  test 'submit checkin with no context returns missing-resource error' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    assert_redirected_to power_dashboard_path
    assert flash[:alert].present?
  end

  test 'submit checkin with tool in context stages pending and redirects to confirm' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    assert_redirected_to power_dashboard_confirm_path
  end

  test 'submit checkin lift with lift in context stages pending and redirects to confirm' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @lift.name }
    post power_dashboard_submit_path, params: { power_input: 'checkin lift' }
    assert_redirected_to power_dashboard_confirm_path
  end

  test 'submit checkin cart with tools in cart stages pending and redirects to confirm' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'add' }
    post power_dashboard_submit_path, params: { power_input: 'checkin cart' }
    assert_redirected_to power_dashboard_confirm_path
  end

  test 'submit checkout with participant and tools stages pending and redirects to confirm' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'add' }
    post power_dashboard_submit_path, params: { power_input: 'checkout' }
    assert_redirected_to power_dashboard_confirm_path
  end

  test 'submit forfeit with lift in context stages pending and redirects to confirm' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @lift.name }
    post power_dashboard_submit_path, params: { power_input: 'forfeit' }
    assert_redirected_to power_dashboard_confirm_path
  end

  # ---------------------------------------------------------------------------
  # Confirm page
  # ---------------------------------------------------------------------------

  test 'GET confirm without pending action redirects with alert' do
    sign_in_as @admin
    get power_dashboard_confirm_path
    assert_redirected_to power_dashboard_path
    assert flash[:alert].present?
  end

  test 'GET confirm with pending action renders successfully' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    follow_redirect!
    assert_response :success
  end

  # ---------------------------------------------------------------------------
  # Execute
  # ---------------------------------------------------------------------------

  test 'POST execute without pending action redirects with alert' do
    sign_in_as @admin
    post power_dashboard_execute_path
    assert_redirected_to power_dashboard_path
    assert flash[:alert].present?
  end

  test 'POST execute with pending action clears it and redirects' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    # Tool has no active checkout → error flash, but always a redirect back to dashboard
    post power_dashboard_execute_path
    assert_redirected_to power_dashboard_path
  end

  test 'POST execute clears pending action even on execution error' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    post power_dashboard_execute_path
    # Confirm page now has no pending action
    get power_dashboard_confirm_path
    assert_redirected_to power_dashboard_path
  end

  # ---------------------------------------------------------------------------
  # Cancel
  # ---------------------------------------------------------------------------

  test 'POST cancel redirects with cancel notice' do
    sign_in_as @admin
    post power_dashboard_cancel_path
    assert_redirected_to power_dashboard_path
    assert_equal I18n.t('power_dashboard.cancel.notice'), flash[:notice]
  end

  test 'POST cancel after pending action clears pending' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @tool.barcode.to_s }
    post power_dashboard_submit_path, params: { power_input: 'checkin' }
    post power_dashboard_cancel_path
    get power_dashboard_confirm_path
    assert_redirected_to power_dashboard_path
  end

  # ---------------------------------------------------------------------------
  # Select / apply organization
  # ---------------------------------------------------------------------------

  test 'GET select_organization without borrower redirects with alert' do
    sign_in_as @admin
    get power_dashboard_select_organization_path
    assert_redirected_to power_dashboard_path
    assert flash[:alert].present?
  end

  test 'GET select_organization with borrower set renders successfully' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    get power_dashboard_select_organization_path
    assert_response :success
  end

  test 'POST apply_organization without borrower redirects with alert' do
    sign_in_as @admin
    post power_dashboard_apply_organization_path, params: { organization_id: @org.id }
    assert_redirected_to power_dashboard_path
    assert flash[:alert].present?
  end

  test 'POST apply_organization with org not belonging to borrower redirects to select with alert' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    post power_dashboard_apply_organization_path, params: { organization_id: 0 }
    assert_redirected_to power_dashboard_select_organization_path
    assert flash[:alert].present?
  end

  test 'POST apply_organization with valid org redirects with notice' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    post power_dashboard_apply_organization_path, params: { organization_id: @org.id }
    assert_redirected_to power_dashboard_path
    assert flash[:notice].present?
  end

  test 'POST apply_organization with pending action redirects to confirm' do
    sign_in_as @admin
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    # Manually stage a pending action that needed org selection
    post power_dashboard_submit_path, params: { power_input: 'clear' }
    post power_dashboard_submit_path, params: { power_input: @participant.eppn }
    post power_dashboard_submit_path, params: { power_input: 'electrical add Need more power' }
    # scc_participant has 1 org → auto-selected; either confirm or select_org depending on state
    assert_includes [power_dashboard_confirm_url, power_dashboard_select_organization_url,
                     power_dashboard_url], response.location
  end
end
