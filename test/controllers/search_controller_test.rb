require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    Post.create(body: "Hello", user_id: users(:current).id)
    get "/search?q=hello"
    assert_response :success
  end
end
