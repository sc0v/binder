# frozen_string_literal: true

require 'test_helper'

class Participants::SafetyBriefingsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    participant = FactoryBot.create(:participant)
    sign_in_as(participant)
    get safety_briefing_url

    assert_response :success
  end
end
