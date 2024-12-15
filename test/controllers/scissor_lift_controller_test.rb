require "test_helper"

class ScissorLiftControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scissor_lift_index_url
    assert_response :success
  end
end
