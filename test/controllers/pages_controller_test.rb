require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get privary" do
    get "/privacy"
    assert_response :success
  end

  test "should get terms" do
    get "/terms"
    assert_response :success
  end

  test "should get about" do
    get "/about"
    assert_response :success
  end
end
