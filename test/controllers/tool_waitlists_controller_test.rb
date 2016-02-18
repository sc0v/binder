require 'test_helper'

class ToolWaitlistsControllerTest < ActionController::TestCase
  setup do
    @tool_waitlist = tool_waitlists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tool_waitlists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tool_waitlist" do
    assert_difference('ToolWaitlist.count') do
      post :create, tool_waitlist: {  }
    end

    assert_redirected_to tool_waitlist_path(assigns(:tool_waitlist))
  end

  test "should show tool_waitlist" do
    get :show, id: @tool_waitlist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tool_waitlist
    assert_response :success
  end

  test "should update tool_waitlist" do
    patch :update, id: @tool_waitlist, tool_waitlist: {  }
    assert_redirected_to tool_waitlist_path(assigns(:tool_waitlist))
  end

  test "should destroy tool_waitlist" do
    assert_difference('ToolWaitlist.count', -1) do
      delete :destroy, id: @tool_waitlist
    end

    assert_redirected_to tool_waitlists_path
  end
end
