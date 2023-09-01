class PostReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    reaction = @post.post_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @post_reaction = PostReaction.new
    if @post.user != current_user
      @notification = Notification.create(user: @post.user, subjectable: reaction)
      @notification.broadcast_prepend_to("notifications-for-#{@post.user.id}")
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    reaction = @post.post_reactions.find(params[:id])
    reaction.destroy
    @post_reaction = PostReaction.new
    @post.broadcast_replace_to("posts")
  end

  def index
    @post = Post.find(params[:post_id])
  end

  private def reaction_params
    params.require(:post_reaction).permit(:body)
  end
end
