module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      skip_forgery_protection

      def preview
        @comment = Comment.new(body: comment_params[:body])
        render json: { body: @comment.html.html_safe }
      end

      def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user
        @comment.save
        @post.broadcast_remove_to("posts")
        @post.broadcast_prepend_to("posts")
        @comment.broadcast_prepend_to("comments")
        render json: { comment: CommentSerializer.render_as_hash(@comment) }
      end

      def update
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        if @comment.user != current_user
          render json: { error: "You are not authorized to edit this comment." }, status: 401
          return
        end
        @comment.update(comment_params)
        @post.broadcast_remove_to("posts")
        @post.broadcast_prepend_to("posts")
        @comment.broadcast_replace_to("comments")
        render json: { comment: CommentSerializer.render_as_hash(@comment) }
      end

      def destroy
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        if @comment.user != current_user
          render json: { error: "You are not authorized to delete this comment." }, status: 401
          return
        end
        @comment.destroy
        @post.broadcast_remove_to("posts")
        @post.broadcast_prepend_to("posts")
        @comment.broadcast_remove_to("comments")
        render json: {}, status: 204
      end

      private def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
