require 'test_helper'

class CarnivalCreationControllerTest < ActionController::TestCase
  test "should get showUploader" do
    get :showUploader
    assert_response :success
  end

  test "should get showDiff" do
    get :showDiff
    assert_response :success
  end

end
