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

  test "should get index" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      get api_v1_posts_url
      assert_response :success
    end
  end

  test "guests should get index" do
    get api_v1_posts_url
    assert_response :success
  end

  test "should get trending" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      get api_v1_posts_trending_url
      assert_response :success
    end
  end

  test "guests should get trending" do
    get api_v1_posts_trending_url
    assert_response :success
  end

  test "should get following tineline" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      get api_v1_posts_following_url
      assert_response :success
    end
  end

  test "guest should not get following timeline" do
    get api_v1_posts_following_url
    assert_response :unauthorized
  end

  test "should get pinned posts" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      get api_v1_posts_pinned_url
      assert_response :success
    end
  end

  test "guest should not get pinned timeline" do
    get api_v1_posts_pinned_url
    assert_response :unauthorized
  end

  test "should get post" do
    get api_v1_post_url(posts(:my_post))
    assert_response :success
  end

  test "should not get not exist post" do
    get api_v1_post_url(999)
    assert_response :not_found
  end
end
