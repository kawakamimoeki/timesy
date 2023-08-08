require "test_helper"

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get preview" do
    post api_v1_preview_comment_url, params: { comment: { body: "Hello, world!" } }
    assert_response :success
  end

  test "should create comment" do
    user = users(:general)
    post = posts(:general)
    access_token = AccessToken.create(user: user)
    post api_v1_create_comment_url(post), params: { comment: { body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not create comment" do
    post = posts(:general)
    post api_v1_create_comment_url(post), params: { comment: { body: "Hello, world!" } }
    assert_response :unauthorized
  end

  test "should not create post with invalid access token" do
    user = users(:general)
    post = posts(:general)
    post api_v1_create_comment_url(post), params: { comment: { body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end

  test "should update comment" do
    user = users(:general)
    post = posts(:general)
    access_token = AccessToken.create(user: user)
    comment = comments(:general)
    patch api_v1_update_comment_url(comment.post, comment), params: { comment: { id: comment.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not update comment" do
    user = users(:general)
    comment = comments(:general)
    patch api_v1_update_comment_url(comment.post, comment), params: { comment: { id: comment.id, body: "Hello, world!" } }
    assert_response :unauthorized
  end

  test "should not update comment with invalid access token" do
    user = users(:general)
    comment = comments(:general)
    patch api_v1_update_comment_url(comment.post, comment), params: { comment: { id: comment.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end

  test "should destroy comment" do
    user = users(:general)
    access_token = AccessToken.create(user: user)
    comment = comments(:general)
    delete api_v1_delete_comment_url(comment.post, comment),
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not destroy comment" do
    user = users(:general)
    comment = comments(:general)
    delete api_v1_delete_comment_url(comment.post, comment)
    assert_response :unauthorized
  end

  test "should not destroy comment with invalid access token" do
    user = users(:general)
    comment = comments(:general)
    delete api_v1_delete_comment_url(comment.post, comment),
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end
end
