module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      skip_forgery_protection

      def preview
        @post = Post.new(body: post_params[:body])
        render json: { body: @post.html.html_safe }
      end

      def create
        @post = Post.new(post_params)
        @post.user = current_user
        @post.attach_projects!
        @post.save
        @post.broadcast_prepend_to("posts")
        render json: { post: PostSerializer.render_as_hash(@post) }
      end

      def update
        @post = Post.find(params[:id])
        if @post.user != current_user
          render json: { error: "You are not authorized to edit this post." }, status: 401
          return
        end
        @post.update(post_params)
        @post.attach_projects!
        @post.broadcast_replace_to("posts")
        render json: { post: PostSerializer.render_as_hash(@post) }
      end

      def destroy
        @post = Post.find(params[:id])
        if @post.user != current_user
          render json: { error: "You are not authorized to delete this post." }, status: 401
          return
        end
        @post.destroy
        @post.broadcast_remove_to("posts")
        render json: {}, status: 204
      end

      private def post_params
        params.require(:post).permit(:body)
      end
    end
  end
end
