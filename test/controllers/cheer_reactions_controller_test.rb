require "test_helper"

class CheerReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create" do
    cheer = cheers(:to_my_post)
    ApplicationController.stub_any_instance :current_user, users(:current) do
      assert_difference('CheerReaction.count') do
        post create_cheer_reaction_path(cheer.post.id, cheer.id), params: { cheer_reaction: { body: 'test' } }
      end
    end
  end

  test "should destroy" do
    cheer_reaction = cheer_reactions(:to_others_cheer)
    ApplicationController.stub_any_instance :current_user, users(:current) do
      assert_difference('CheerReaction.count', -1) do
        delete delete_cheer_reaction_path(cheer_reaction.cheer.post, cheer_reaction.cheer, cheer_reaction)
      end
    end
  end
end
