require 'test_helper'

class CarnivalCreationControllerTest < ActionController::TestCase
<<<<<<< HEAD
  test "should get show-wizard" do
    get :show-wizard
=======
  test "should get showUploader" do
    get :showUploader
    assert_response :success
  end

  test "should get showDiff" do
    get :showDiff
>>>>>>> carnival-creation-frontend
    assert_response :success
  end

end
