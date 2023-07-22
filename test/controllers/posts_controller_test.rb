require "test_helper"
require 'minitest/mock'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get edit" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post = posts(:general)
      get "/posts/#{post.id}/edit"
      assert_response :success
    end
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

  test "should destroy post" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post = posts(:general)
      assert_difference('Post.count', -1) do
        delete "/posts/#{post.id}"
      end
    end
  end
end
