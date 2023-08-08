class PostReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    reaction = @post.post_reactions.new(reaction_params)
    reaction.user = current_user
    reaction.save
    @post.broadcast_replace_to("posts")
    @post_reaction = PostReaction.new
    if @post.user != current_user
      @notification = Notification.create(user: @post.user, subjectable: reaction)
      @notification.broadcast_prepend_to("notifications-for-#{@post.user.id}")
      if @post.user.webhook_url.present?
        WebhookJob.perform_later(
          distination: @post.user.webhook_url,
          type: "post_reaction",
          subject: Webhooks::PostReactionSerializer.render_as_hash(reaction),
          message: I18n.t("webhooks.post_reaction", user: reaction.user.name),
          url: post_url(@post),
        )
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    reaction = @post.post_reactions.find(params[:id])
    reaction.destroy
    @post_reaction = PostReaction.new
    @post.broadcast_replace_to("posts")
  end

  def list
    @post = Post.find(params[:post_id])
  end

  private def reaction_params
    params.require(:post_reaction).permit(:body)
  end
end
