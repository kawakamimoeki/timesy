class SitemapController < ApplicationController
  def index
    @posts = Post.latest
  end
end
