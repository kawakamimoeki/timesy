require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get "/search?q=hello"
    assert_response :success
  end
end
