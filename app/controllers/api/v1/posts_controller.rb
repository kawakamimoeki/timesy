module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      skip_forgery_protection

      def index
        current_page = params[:page] ? params[:page].to_i : 0
        per_page = params[:per_page] ? params[:per_page].to_i : 10
        posts = Post.offset(per_page*current_page)
          .latest
          .limit(per_page)
        render json: { posts: PostSerializer.render_as_hash(posts) }
      end

      def following
        unless current_user
          render json: { error: "Unauthorized" }, status: 401
          return
        end

        current_page = params[:page].to_i
        per_page = params[:per_page].to_i
        posts = Post.offset(per_page*current_page)
          .latest
          .limit(per_page)
          .following(current_user)
        render json: { posts: PostSerializer.render_as_hash(posts) }
      end

      def trending
        render json: { posts: PostSerializer.render_as_hash(Post.trending.limit(5))}
      end

      def pinned
        unless current_user
          render json: { error: "Unauthorized" }, status: 401
          return
        end

        current_page = params[:page].to_i
        per_page = params[:per_page].to_i
        posts = Post.offset(per_page*current_page)
          .pinned_by(current_user)
          .latest
          .limit(per_page)
        
        render json: { posts: "hoge" }
      end

      def show
        post = Post.includes(comments: :user).find_by(id: params[:id])
        if post.nil?
          render json: { error: "Not found" }, status: 404
          return
        end
    
        comments = post.comments
          .includes(:user, comment_reactions: :user)
          .latest
        
        render json: { post: PostSerializer.render_as_hash(post, view: :thread) }
      end    

      def preview
        post = Post.new(body: post_params[:body])
        render json: { body: post.html.html_safe }
      end

      def create
        post = Post.new(post_params)
        post.user = current_user
        post.attach_projects!
        post.save
        CreateProjectJob.perform_later(post)
        render json: { post: PostSerializer.render_as_hash(post) }
      end

      def update
        post = Post.find(params[:id])
        if post.user != current_user
          render json: { error: "You are not authorized to edit this post." }, status: 401
          return
        end
        post.update(post_params)
        post.attach_projects!
        CreateProjectJob.perform_later(post)
        render json: { post: PostSerializer.render_as_hash(post) }
      end

      def destroy
        post = Post.find(params[:id])
        if post.user != current_user
          render json: { error: "You are not authorized to delete this post." }, status: 401
          return
        end
        post.destroy
        render json: {}, status: 204
      end

      private def post_params
        params.require(:post).permit(:body)
      end
    end
  end
end
