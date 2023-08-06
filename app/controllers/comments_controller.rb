class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create!(comment_params.merge(user: current_user, post: @post))
    @comment.images.attach(comment_params[:images]) if comment_params[:images].present?
    @post.broadcast_remove_to("posts")
    @post.broadcast_prepend_to("posts")
    @comment.broadcast_prepend_to("comments")

    if @post.user != current_user
      Notification.create(user: @post.user, subjectable: @comment)
      if @post.user.webhook_url.present?
        WebhookJob.perform_later(
          distination: @post.user.webhook_url,
          type: "comment",
          subject: Webhooks::CommentSerializer.render_as_hash(@comment),
          message: I18n.t("webhooks.comment", user: @comment.user.name),
          url: post_url(@post),
        )
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.user != current_user
      render json: { error: 'You are not authorized to delete this comment.' }, status: :unauthorized
      return
    end

    @comment.destroy!
    @post.broadcast_remove_to("posts")
    @post.broadcast_prepend_to("posts")
    @comment.broadcast_remove_to("comments")
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.user != current_user
      render json: { error: 'You are not authorized to edit this comment.' }, status: :unauthorized
      return
    end

    @comment.update!(comment_params)
    @comment.images.attach(comment_params[:images]) if comment_params[:images].present?
    @post.broadcast_remove_to("posts")
    @post.broadcast_prepend_to("posts")
    @comment.broadcast_remove_to("comments")
    @comment.broadcast_prepend_to("comments")
  end

  def comment_editor
    @comment = Comment.find(params[:id])
  end

  private def comment_params
    params.require(:comment).permit(:body, images: [])
  end
end
