# frozen_string_literal: true

require 'test_helper'

class ScissorLiftControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    sign_in_as(FactoryBot.create(:participant, admin: true))
    get scissor_lifts_url

    assert_response :success
  end
end
