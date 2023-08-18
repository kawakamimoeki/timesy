require "test_helper"

class CommentReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    comment = comments(:general)
    get comment_reactions_path(comment.post.id, comment.id)
    assert_response :success
  end

  test "should create" do
    comment = comments(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('CommentReaction.count') do
        post create_comment_reaction_path(comment.post.id, comment.id), params: { comment_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    comment = comments(:general)
    ApplicationController.stub_any_instance :current_user, users(:general) do
      assert_difference('CommentReaction.count', -1) do
        delete delete_comment_reaction_path(comment.post, comment, comment_reactions(:general))
      end
    end
  end
end
