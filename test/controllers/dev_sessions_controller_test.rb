# frozen_string_literal: true

require 'test_helper'

class DevSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin =
      FactoryBot.create(:participant, eppn: 'aa00@andrew.cmu.edu', admin: true)
  end

  test 'shows the test accounts in development and test' do
    get dev_login_path

    assert_response :success
    assert_includes response.body, 'Andy Admin'
  end

  test 'Sign In goes to the developer sign-in page in development and test' do
    assert_equal '/login', Rails.application.routes.url_helpers.login_path
  end

  %w[staging production].each do |env|
    test "is not found in #{env}" do
      with_rails_env(env) do
        get dev_login_path

        assert_response :not_found

        post dev_login_as_path(@admin)

        assert_response :not_found
      end
    end

    test "Sign In goes to single sign-on in #{env}" do
      with_rails_env(env) do
        assert_equal '/auth/saml',
                     Rails.application.routes.url_helpers.login_path
      end
    end
  end

  test 'signs in and goes back to the page on this site it came from' do
    post dev_login_as_path(@admin), params: { return_to: '/scissor_lifts?x=1' }

    assert_redirected_to '/scissor_lifts?x=1'
  end

  test 'goes home for another site' do
    post dev_login_as_path(@admin),
         params: {
           return_to: 'https://example.com/scissor_lifts'
         }

    assert_redirected_to root_path
  end

  test 'goes home for a protocol-relative address' do
    post dev_login_as_path(@admin), params: { return_to: '//example.com/' }

    assert_redirected_to root_path
  end

  test 'never goes back to the developer sign-in page or single sign-on' do
    post dev_login_as_path(@admin), params: { return_to: '/login' }

    assert_redirected_to root_path

    post dev_login_as_path(@admin), params: { return_to: '/auth/saml' }

    assert_redirected_to root_path
  end

  test 'Signed Out goes back where it came from' do
    sign_in_as(@admin)
    post dev_logout_path, params: { return_to: '/scissor_lifts' }

    assert_redirected_to '/scissor_lifts'
  end
end
