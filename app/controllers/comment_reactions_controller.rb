class CommentReactionsController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    reaction = @comment.comment_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @comment_reaction = CommentReaction.new
    if @comment.user != current_user
      Notification.create(user: @comment.user, subjectable: reaction)
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
  end

  private def reaction_params
    params.require(:comment_reaction).permit(:body)
  end
end
