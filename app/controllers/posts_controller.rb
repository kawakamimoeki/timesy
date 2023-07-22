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
    @posts = Post.includes(:user).latest
    @post = Post.new
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

  def edit
    @post = Post.find(params[:id])
    render :edit, layout: 'editor'
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
