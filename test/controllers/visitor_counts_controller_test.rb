require "test_helper"

class VisitorCountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get visitor_counts_index_url
    assert_response :success
  end

  test "should get show" do
    get visitor_counts_show_url
    assert_response :success
  end

  test "should get update" do
    get visitor_counts_update_url
    assert_response :success
  end

  test "should get search" do
    get visitor_counts_search_url
    assert_response :success
  end
end
