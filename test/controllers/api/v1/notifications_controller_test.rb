require "test_helper"

class Api::V1::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should post read" do
    notification = Notification.create!(user: users(:general), subjectable: follows(:one))
    ApplicationController.stub_any_instance :current_user, users(:general) do
      post api_v1_read_notifications_url
      assert_response :success
    end
  end
end
