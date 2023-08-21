require "test_helper"

class CheersControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get cheer_form_url(post_id: posts(:my_post).id)
    assert_response :success
  end

  test "should get form with current user" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      get cheer_form_url(post_id: posts(:my_post).id)
      assert_response :success
    end
  end

  test "should get index" do
    get "/posts/#{posts(:my_post).id}/cheers.turbo_stream"
    assert_response :success
  end

  test "should get create" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      post "/posts/#{posts(:my_post).id}/cheers.turbo_stream", params: { cheer: { body: "Hello" } }
      assert_response :success
    end
  end

  test "should get create with empty body" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      post "/posts/#{posts(:my_post).id}/cheers.turbo_stream", params: { cheer: { body: "" } }
      assert_response :success
    end
  end

  test "should update" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      patch "/posts/#{posts(:my_post).id}/cheers/#{cheers(:to_others_post).id}.turbo_stream", params: { cheer: { body: "Hello" } }
      assert_response :success
    end
  end

  test "should not update if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      patch "/posts/#{posts(:my_post).id}/cheers/#{cheers(:to_others_post).id}.turbo_stream", params: { cheer: { body: "Hello" } }
      assert_response :unauthorized
    end
  end

  test "should destroy" do
    ApplicationController.stub_any_instance :current_user, users(:current) do
      delete "/posts/#{posts(:my_post).id}/cheers/#{cheers(:to_others_post).id}"
      assert_response :success
    end
  end

  test "should not destroy if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      delete "/posts/#{posts(:my_post).id}/cheers/#{cheers(:to_others_post).id}.turbo_stream"
      assert_response :unauthorized
    end
  end  
end
