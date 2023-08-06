require "test_helper"

class CommentReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create" do
    comment = comments(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('CommentReaction.count') do
        post create_comment_reaction_path(comment.post.id, comment.id, format: :turbo_stream), params: { comment_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    comment = comments(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('CommentReaction.count', -1) do
        delete delete_comment_reaction_path(comment.post, comment, comment_reactions(:general), format: :turbo_stream)
      end
    end
  end
end
