class CommentReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @post.broadcast_replace_to("posts")
    @comment.broadcast_replace_to("comments-of-#{params[:post_id]}")
    @comment_reaction = CommentReaction.new
    if @comment.user != current_user
      @notification = Notification.create(user: @comment.user, subjectable: reaction)
      @notification.broadcast_prepend_to("notifications-for-#{@comment.user.id}")
      if @comment.user.webhook_url.present?
        WebhookJob.perform_later(
          distination: @comment.user.webhook_url,
          type: "comment_reaction",
          subject: Webhooks::CommentReactionSerializer.render_as_hash(reaction),
          message: I18n.t("webhooks.comment_reaction", user: reaction.user.name),
          url: post_url(@comment.post),
        )
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.find(params[:id])
    reaction.destroy
    @comment_reaction = CommentReaction.new
    @comment.broadcast_replace_to("comments-of-#{params[:post_id]}")
  end

  def list
    @comment = Comment.find(params[:comment_id])
  end

  private def reaction_params
    params.require(:comment_reaction).permit(:body)
  end
end
