module Api
  module V1
    class PostsController < ApplicationController
      def preview
        @post = Post.new(body: post_params[:body])
        render json: { body: @post.html.html_safe }
      end

      private def post_params
        params.require(:post).permit(:body)
      end
    end
  end
end
