class SearchController < ApplicationController
  def index
    comments = Comment.search(params[:q])
    posts = Post.search(params[:q])
    @current_page = params[:page].to_i
    posts_for_comments = comments.map(&:post)
    @posts = (posts + posts_for_comments).uniq
  end

  private def page_limit
    10
  end
end
