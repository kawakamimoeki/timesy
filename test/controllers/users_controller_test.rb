require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get sign_up" do
    get "/users/sign_up"
    assert_response :success
  end

  test "should post create" do
    post "/users", params: { user: { email: "test@example.com", username: "test", name: "Test" } }
    assert_response :success
  end

  test "should get sign_in" do
    get "/users/sign_in"
    assert_response :success
  end

  test "should post confirm" do
    post "/users/confirm", params: { user: { email: "notexist@example.com" } }
    follow_redirect!
    assert_response :success
  end

  test "should get register" do
    session = EmailConfirmationSession.create(email: "test@example.com")
    get "/users/register/#{session.token}"
    assert_response :success
  end

  test "should get show" do
    user = users(:general)
    get "/users/#{user.username}"
    assert_response :success
  end

  test "should delete destroy" do
    user = users(:general)
    delete "/users/#{user.id}"
    assert_response :redirect
  end
end
