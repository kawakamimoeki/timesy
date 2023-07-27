require "test_helper"

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get preview" do
    post api_v1_preview_post_url, params: { post: { body: "Hello, world!" } }
    assert_response :success
  end
end
