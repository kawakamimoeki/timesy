require "test_helper"

class CommentReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create" do
    comment = comments(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('CommentReaction.count') do
        post create_comment_reaction_path(post_id: comment.post.id, comment_id: comment.id), params: { comment_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    comment = comments(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('CommentReaction.count', -1) do
        delete delete_comment_reaction_path(post_id: comment.post.id, comment_id: comment.id, id: comment_reactions(:general).id)
      end
    end
  end
end
