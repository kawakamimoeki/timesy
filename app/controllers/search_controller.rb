class SearchController < ApplicationController
  def index
    @posts = Post.search(params[:q])
  end
end
