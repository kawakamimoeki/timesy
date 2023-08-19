require "test_helper"

class Api::V1::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should post read" do
    notification = Notification.create!(user: users(:current), subjectable: follows(:from_other))
    ApplicationController.stub_any_instance :current_user, users(:current) do
      post api_v1_read_notifications_url
      assert_response :success
    end
  end
end
