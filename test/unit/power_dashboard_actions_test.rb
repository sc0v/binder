# frozen_string_literal: true

require 'test_helper'

class PowerDashboardActionsTest < ActiveSupport::TestCase
  fixtures :all

  def setup
    @participant = participants(:scc_participant)
    @organization = organizations(:scc)
    @tool = Tool.find(1)
    @lift = scissor_lifts(:two)
  end

  test 'parser covers every registered action with command samples' do
    assert_parsed_action('add', 'add_tool') { |s| s.set_current_resource(:tool, @tool) }
    assert_parsed_action('remove', 'remove_tool') { |s| s.set_current_resource(:tool, @tool) }
    assert_parsed_action('clear', 'clear_session')
    assert_parse_error('checkin') # checkin_missing_resource

    assert_parsed_action('checkin cart', 'checkin_tools_cart') { |s| s.session[:tools] = [@tool.id] }
    assert_parsed_action('checkin', 'checkin_tool') { |s| s.set_current_resource(:tool, @tool) }
    assert_parsed_action('checkin', 'checkin_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }
    assert_parsed_action('checkin lift', 'checkin_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }

    assert_parsed_action('checkout', 'checkout_tools_cart') do |s|
      s.set_participant(@participant)
      s.session[:tools] = [@tool.id]
    end
    assert_parsed_action('checkout lift', 'checkout_scissor_lift') { |s| s.set_participant(@participant) }
    assert_parsed_action('renew 2', 'renew_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }
    assert_parsed_action('forfeit', 'forfeit_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }

    assert_parsed_action('electrical', 'select_queue')
    assert_parsed_action('queue add Need more power', 'add_queue') do |s|
      s.set_participant(@participant)
      s.set_queue_resource('electrical')
      assert_equal @organization.id, s.current_organization&.id
    end
    assert_parsed_action('queue remove', 'remove_queue') do |s|
      s.set_participant(@participant)
      s.set_queue_resource('electrical')
    end

    assert_parsed_action('lifts', 'select_scissor_lifts_overview')
    assert_parsed_action('auto', 'toggle_auto_add')
  end

  test 'parser supports all documented command aliases' do
    # tool add aliases
    assert_parsed_action('add', 'add_tool') { |s| s.set_current_resource(:tool, @tool) }
    assert_parsed_action('a', 'add_tool') { |s| s.set_current_resource(:tool, @tool) }

    # tool remove aliases
    assert_parsed_action('remove', 'remove_tool') { |s| s.set_current_resource(:tool, @tool) }
    assert_parsed_action('rem', 'remove_tool') { |s| s.set_current_resource(:tool, @tool) }
    assert_parsed_action('r', 'remove_tool') { |s| s.set_current_resource(:tool, @tool) }

    # checkin cart aliases
    %w[checkin\ cart in\ cart checkin\ c in\ c checkin\ tool checkin\ tools].each do |command|
      assert_parsed_action(command, 'checkin_tools_cart') { |s| s.session[:tools] = [@tool.id] }
    end

    # checkin lift aliases
    %w[checkin\ lift checkin\ l in\ lift in\ l].each do |command|
      assert_parsed_action(command, 'checkin_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }
    end

    # checkout cart aliases
    %w[checkout out checkout\ cart checkout\ c checkout\ tool checkout\ tools].each do |command|
      assert_parsed_action(command, 'checkout_tools_cart') do |s|
        s.set_participant(@participant)
        s.session[:tools] = [@tool.id]
      end
    end

    # checkout lift aliases
    %w[checkout\ lift checkout\ l out\ lift out\ l].each do |command|
      assert_parsed_action(command, 'checkout_scissor_lift') { |s| s.set_participant(@participant) }
    end

    # renew aliases
    assert_parsed_action('renew 2', 'renew_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }
    assert_parsed_action('ren 2', 'renew_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }

    # queue select aliases
    assert_parsed_action('electrical', 'select_queue')
    assert_parsed_action('e', 'select_queue')
    assert_parsed_action('structural', 'select_queue')
    assert_parsed_action('s', 'select_queue')

    # queue add aliases
    %w[queue\ add\ Need\ power q\ add\ Need\ power queue\ a\ Need\ power q\ a\ Need\ power electrical\ add\ Need\ power e\ add\ Need\ power structural\ add\ Need\ power s\ add\ Need\ power].each do |command|
      assert_parsed_action(command, 'add_queue') do |s|
        s.set_participant(@participant)
        s.set_queue_resource('electrical') if command.start_with?('queue ', 'q ')
      end
    end

    # queue remove aliases
    %w[queue\ remove q\ remove queue\ rem queue\ r q\ rem q\ r electrical\ remove e\ rem structural\ remove s\ rem].each do |command|
      assert_parsed_action(command, 'remove_queue') do |s|
        s.set_participant(@participant)
        s.set_queue_resource('electrical') if command.start_with?('queue ', 'q ')
      end
    end

    assert_parsed_action('forfeit', 'forfeit_scissor_lift') { |s| s.set_current_resource(:scissor_lift, @lift) }
    assert_parsed_action('lifts', 'select_scissor_lifts_overview')
    assert_parsed_action('auto', 'toggle_auto_add')
    assert_parsed_action('clear', 'clear_session')
  end

  test 'all confirmation-required actions are blocked unless confirmed' do
    executor = PowerDashboard::ActionExecutor.new(
      session_state: PowerDashboard::SessionState.new({}),
      ability: ->(_action, _resource) { true }
    )
    expected_error = I18n.t('power_dashboard.actions.confirmation_required')

    PowerDashboard::ActionRegistry.handlers.select(&:confirmation_required?).each do |handler|
      result = executor.execute('action' => handler.name)
      assert_equal expected_error, result[:error], "expected confirmation gate for #{handler.name}"
    end
  end

  private

  def assert_parsed_action(input, expected_action = nil)
    session = {}
    session_state = PowerDashboard::SessionState.new(session)
    yield(session_state) if block_given?
    parser = PowerDashboard::ActionParser.new(session_state: session_state)
    result = parser.parse(input)

    assert result.present?, "expected parser result for: #{input}"
    assert_nil result[:error], "unexpected parse error for #{input}: #{result[:error]}"
    assert_equal expected_action, result.dig(:pending, :action) if expected_action.present?
  end

  def assert_parse_error(input)
    parser = PowerDashboard::ActionParser.new(session_state: PowerDashboard::SessionState.new({}))
    result = parser.parse(input)
    assert result.present?, "expected parser result for: #{input}"
    assert result[:error].present?, "expected parse error for: #{input}"
  end
end
