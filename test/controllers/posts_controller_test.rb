require "test_helper"
require 'minitest/mock'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get post_form_url
    assert_response :success
  end

  test "should get form with current user" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get post_form_url
      assert_response :success
    end
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get latest" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get latest_url
      assert_response :success
    end
  end

  test "should get pinned" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get pinned_url
      assert_response :success
    end
  end

  test "should get editor" do
    get post_editor_url(posts(:general))
    assert_response :success
  end

  test "should get editor with current user" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get post_editor_url(posts(:general))
      assert_response :success
    end
  end

  test "should create post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('Post.count') do
        post "/posts.turbo_stream", params: { post: { title: "foo", body: "bar", general: true } }
      end
    end
  end

  test "should update post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post = posts(:general)
      patch "/posts/#{post.id}.turbo_stream", params: { post: { title: "foo", body: "bar", general: true } }
    end
  end

  test "should not update post if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      post = posts(:general)
      patch "/posts/#{post.id}.turbo_stream", params: { post: { title: "foo", body: "bar", general: true } }
      assert_response :unauthorized
    end
  end

  test "should destroy post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post = posts(:general)
      assert_difference('Post.count', -1) do
        delete "/posts/#{post.id}.turbo_stream"
      end
    end
  end

  test "should not destroy post if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      post = posts(:general)
      assert_difference('Post.count', 0) do
        delete "/posts/#{post.id}.turbo_stream"
      end
      assert_response :unauthorized
    end
  end
end
