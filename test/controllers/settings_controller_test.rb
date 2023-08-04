require "test_helper"
require 'minitest/mock'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      get "/settings"
      assert_response :success
    end
  end

  test "should get create" do
    ApplicationController.stub_any_instance :current_user, users(:general) do
      patch "/settings/profile", params: { user: { email: "new@example.com", username: "new", name: "New" } }
      assert_response :redirect
    end
  end
end
