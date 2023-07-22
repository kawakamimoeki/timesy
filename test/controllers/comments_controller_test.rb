require "test_helper"
require 'minitest/mock'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post "/posts/#{posts(:general).id}/comments", params: { comment: { body: "Hello" } }
      assert_response :success
    end
  end

  test "should get create with empty body" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post "/posts/#{posts(:general).id}/comments", params: { comment: { body: "" } }
      assert_response :success
    end
  end

  test "should destroy" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      delete "/posts/#{posts(:general).id}/comments/#{comments(:general).id}"
      assert_response :success
    end
  end
end
