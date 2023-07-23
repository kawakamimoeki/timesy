class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    Comment.create!(comment_params.merge(user: current_user, post: @post))
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy!
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.update!(comment_params)
  end

  private def comment_params
    params.require(:comment).permit(:body)
  end
end
