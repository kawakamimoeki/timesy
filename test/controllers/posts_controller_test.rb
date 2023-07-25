require "test_helper"
require 'minitest/mock'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get index with dev" do
    get "/?dev=true"
    assert_response :success
  end

  test "should get search" do
    get "/search?q=foo"
    assert_response :success
  end

  test "should create post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('Post.count') do
        post "/new-post", params: { post: { title: "foo", body: "bar", general: true } }
      end
    end
  end

  test "should update post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post = posts(:general)
      patch "/posts/#{post.id}", params: { post: { title: "foo", body: "bar", general: true } }
    end
  end

  test "should not update post if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      post = posts(:general)
      patch "/posts/#{post.id}", params: { post: { title: "foo", body: "bar", general: true } }
      assert_response :unauthorized
    end
  end

  test "should destroy post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post = posts(:general)
      assert_difference('Post.count', -1) do
        delete "/posts/#{post.id}"
      end
    end
  end

  test "should not destroy post if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      post = posts(:general)
      assert_difference('Post.count', 0) do
        delete "/posts/#{post.id}"
      end
      assert_response :unauthorized
    end
  end
end
