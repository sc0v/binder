# frozen_string_literal: true

require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test 'a sign-in cookie for someone who no longer exists signs the browser out' do
    participant = FactoryBot.create(:participant)
    sign_in_as(participant)
    participant.delete

    get root_path

    assert_response :success
    assert_predicate cookies[:user_id], :blank?
  end
end
