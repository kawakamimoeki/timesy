require "test_helper"

class PostReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create" do
    post = posts(:my_post)
    ApplicationController.stub_any_instance :current_user, users(:current) do
      assert_difference('PostReaction.count') do
        post create_post_reaction_path(post_id: post.id), params: { post_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    post_reaction = post_reactions(:to_other_post)
    ApplicationController.stub_any_instance :current_user, users(:current) do
      assert_difference('PostReaction.count', -1) do
        delete delete_post_reaction_path(post_reaction.post, post_reaction)
      end
    end
  end
end
