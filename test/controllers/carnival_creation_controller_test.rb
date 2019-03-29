require 'test_helper'

class CarnivalCreationControllerTest < ActionController::TestCase
  test "should get show-wizard" do
    get :show-wizard
    assert_response :success
  end

end
