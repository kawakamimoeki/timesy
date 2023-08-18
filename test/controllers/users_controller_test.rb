require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get header" do
    get "/users/header"
    assert_response :success
  end

  test "should get header with current user" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get "/users/header"
      assert_response :success
    end
  end

  test "should get timeline_nav" do
    get "/users/timeline_nav"
    assert_response :success
  end

  test "should get timeline_nav with current user" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get "/users/timeline_nav"
      assert_response :success
    end
  end

  test "should get sign_up" do
    get "/sign_up"
    assert_response :success
  end

  test "should post create" do
    post "/users", params: { user: { email: "test@example.com", username: "test", name: "Test" } }
    assert_response :success
  end

  test "should post confirm" do
    post "/users/confirm", params: { user: { email: "notexist@example.com" } }
    assert_response :redirect
  end

  test "should get register" do
    session = EmailConfirmationSession.create(email: "test@example.com")
    get "/users/register/#{session.token}"
    assert_response :success
  end

  test "should redirect to short path" do
    user = users(:general)
    get "/users/#{user.username}"
    assert_redirected_to "/#{user.username}"
  end

  test "should get show" do
    user = users(:general)
    get "/#{user.username}"
    assert_response :success
  end

  test "should get comments" do
    user = users(:general)
    get "/#{user.username}/comments"
    assert_response :success
  end

  test "should get actor" do
    user = users(:general)
    get "/#{user.username}", headers: { "Accept" => "application/activity+json" }
    assert_response :success
  end

  test "should delete destroy" do
    user = users(:general)
    ApplicationController.stub_any_instance :current_user, user do
      delete "/users/#{user.id}"
      assert_response :redirect
    end
  end

  test "should not delete destroy if not authorized" do
    user = users(:general)
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      delete "/users/#{user.id}"
      assert_response :unauthorized
    end
  end

  test "should get followers" do
    user = users(:general)
    get "/#{user.username}/followers"
    assert_response :success
  end

  test "should get following" do
    user = users(:general)
    get "/#{user.username}/following"
    assert_response :success
  end
end
