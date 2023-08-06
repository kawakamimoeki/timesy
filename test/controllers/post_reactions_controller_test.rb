require "test_helper"

class PostReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create" do
    post = posts(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('PostReaction.count') do
        post create_post_reaction_path(post_id: post.id, format: :turbo_stream), params: { post_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    post = posts(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('PostReaction.count', -1) do
        delete delete_post_reaction_path(post_id: post.id, id: post_reactions(:general).id, format: :turbo_stream)
      end
    end
  end
end
