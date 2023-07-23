class PostsController < ApplicationController
  def search
    @q = params[:q]
    if @q.blank?
      @posts = Post.latest
      return
    end
    @posts = Post.search(params[:q]).latest
  end

  def index
    page_limit = 20
    @post = Post.new
    @current_page = params[:page].to_i

    @posts = Post.offset(page_limit*@current_page).includes(:user).latest.limit(page_limit)
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
    render :new, layout: 'editor'
  end

  def create
    @post = Post.create(post_params.merge(user: current_user))
    @posts = Post.includes(:user).latest
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to root_path
  end

  private def post_params
    params.require(:post).permit(:body)
  end
end
