require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get notifications_url
      assert_response :success
    end
  end

  test "should get button" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get notifications_button_url
      assert_response :success
    end
  end
end
