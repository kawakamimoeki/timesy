class CommentReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @comment_reaction = CommentReaction.new
    if @comment.user != current_user
      @notification = Notification.create(user: @comment.user, subjectable: reaction)
      @notification.broadcast_prepend_to("notifications-for-#{@comment.user.id}")
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.find(params[:id])
    reaction.destroy
    @comment_reaction = CommentReaction.new
  end

  def index
    @comment = Comment.find(params[:comment_id])
  end

  private def reaction_params
    params.require(:comment_reaction).permit(:body)
  end
end
