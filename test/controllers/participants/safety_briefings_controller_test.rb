# frozen_string_literal: true
require 'test_helper'

class Participants::SafetyBriefingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get participants_safety_briefings_show_url
    assert_response :success
  end

  test 'should get update' do
    get participants_safety_briefings_update_url
    assert_response :success
  end
end
