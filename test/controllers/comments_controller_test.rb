require "test_helper"
require 'minitest/mock'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/posts/#{posts(:general).id}/comments.turbo_stream"
    assert_response :success
  end

  test "should get create" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post "/posts/#{posts(:general).id}/comments.turbo_stream", params: { comment: { body: "Hello" } }
      assert_response :success
    end
  end

  test "should get create with empty body" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post "/posts/#{posts(:general).id}/comments.turbo_stream", params: { comment: { body: "" } }
      assert_response :success
    end
  end

  test "should update" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      patch "/posts/#{posts(:general).id}/comments/#{comments(:general).id}.turbo_stream", params: { comment: { body: "Hello" } }
      assert_response :success
    end
  end

  test "should not update if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      patch "/posts/#{posts(:general).id}/comments/#{comments(:general).id}.turbo_stream", params: { comment: { body: "Hello" } }
      assert_response :unauthorized
    end
  end

  test "should destroy" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      delete "/posts/#{posts(:general).id}/comments/#{comments(:general).id}"
      assert_response :success
    end
  end

  test "should not destroy if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      delete "/posts/#{posts(:general).id}/comments/#{comments(:general).id}.turbo_stream"
      assert_response :unauthorized
    end
  end
end
