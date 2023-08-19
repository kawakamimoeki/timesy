require "test_helper"

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get preview" do
    post api_v1_preview_post_url, params: { post: { body: "Hello, world!" } }
    assert_response :success
  end

  test "should create post" do
    user = users(:current)
    access_token = AccessToken.create(user: user)
    post api_v1_create_post_url, params: { post: { body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not create post" do
    post api_v1_create_post_url, params: { post: { body: "Hello, world!" } }
    assert_response :unauthorized
  end

  test "should not create post with invalid access token" do
    user = users(:current)
    post api_v1_create_post_url, params: { post: { body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end

  test "should update post" do
    user = users(:current)
    access_token = AccessToken.create(user: user)
    post = posts(:my_post)
    patch api_v1_update_post_url(post), params: { post: { id: post.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not update post" do
    user = users(:current)
    post = posts(:my_post)
    patch api_v1_update_post_url(post), params: { post: { id: post.id, body: "Hello, world!" } }
    assert_response :unauthorized
  end

  test "should not update post with invalid access token" do
    user = users(:current)
    post = posts(:my_post)
    patch api_v1_update_post_url(post), params: { post: { id: post.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end

  test "should not update post with invalid user" do
    user = users(:current)
    user2 = users(:other)
    access_token = AccessToken.create(user: user2)
    post = posts(:my_post)
    patch api_v1_update_post_url(post), params: { post: { id: post.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :unauthorized
  end


  test "should destroy post" do
    user = users(:current)
    access_token = AccessToken.create(user: user)
    post = posts(:my_post)
    delete api_v1_delete_post_url(post),
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not destroy post" do
    user = users(:current)
    post = posts(:my_post)
    delete api_v1_delete_post_url(post)
    assert_response :unauthorized
  end

  test "should not destroy post with invalid access token" do
    user = users(:current)
    post = posts(:my_post)
    delete api_v1_delete_post_url(post),
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end
end
