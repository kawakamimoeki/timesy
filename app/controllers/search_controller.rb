class SearchController < ApplicationController
  def index
    if params[:q].nil?
      @posts = []
    else
      @posts = Post.search(params[:q])
    end
  end
end
