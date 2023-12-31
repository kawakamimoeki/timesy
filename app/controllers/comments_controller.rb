class CommentsController < ApplicationController
  def form
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def index
    @post = Post.find(params[:post_id])
    @current_page = params[:page].to_i

    @comments = @post.comments.oldest
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create!(comment_params.merge(user: current_user, post: @post))
    @comment.images.attach(comment_params[:images]) if comment_params[:images].present?

    if @post.user != current_user
      @notification = Notification.create(user: @post.user, subjectable: @comment)
      @notification.broadcast_prepend_to("notifications-for-#{@post.user.id}")
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
  end

  def comment_editor
    @comment = Comment.find(params[:id])
  end

  private def comment_params
    params.require(:comment).permit(:body, images: [])
  end
end
