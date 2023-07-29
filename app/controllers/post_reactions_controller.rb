class PostReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    reaction = @post.post_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @post_reaction = PostReaction.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    reaction = @post.post_reactions.find(params[:id])
    reaction.destroy
    @post_reaction = PostReaction.new
  end

  private def reaction_params
    params.require(:post_reaction).permit(:body)
  end
end
