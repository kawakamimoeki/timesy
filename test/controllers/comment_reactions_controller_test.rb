require "test_helper"

class CommentReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create" do
    comment = comments(:to_my_post)
    ApplicationController.stub_any_instance :current_user, users(:current) do
      assert_difference('CommentReaction.count') do
        post create_comment_reaction_path(comment.post.id, comment.id), params: { comment_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    comment_reaction = comment_reactions(:to_others_comment)
    ApplicationController.stub_any_instance :current_user, users(:current) do
      assert_difference('CommentReaction.count', -1) do
        delete delete_comment_reaction_path(comment_reaction.comment.post, comment_reaction.comment, comment_reaction)
      end
    end
  end
end
