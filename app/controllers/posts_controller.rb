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
    @post = Post.new
    @current_page = params[:page].to_i
    @dev = ActiveRecord::Type::Boolean.new.cast(params[:dev])

    unless @dev
      @posts = Post.offset(page_limit*@current_page).includes(:user, comments: :user).latest.limit(page_limit)
      @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
    else
      @posts = Post.offset(page_limit*@current_page).includes(:user, comments: :user).latest.where(dev: true).limit(page_limit)
      @next_page = @current_page + 1 if Post.where(dev: true).count > page_limit*@current_page + page_limit
    end
  end

  def show
    @post = Post.includes(comments: :user).find_by(id: params[:id])
    if @post.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
    @comment = Comment.new
  end

  def new
    @post = Post.new
    render :new, layout: 'editor'
  end

  def create
    @post = Post.create(post_params.merge(user: current_user))
    @dev = ActiveRecord::Type::Boolean.new.cast(post_params[:dev])
    @current_page = params[:page].to_i

    unless @dev
      @posts = Post.offset(page_limit*@current_page).includes(:user, comments: :user).latest.limit(page_limit)
      @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
    else
      @posts = Post.offset(page_limit*@current_page).includes(:user, comments: :user).latest.where(dev: true).limit(page_limit)
      @next_page = @current_page + 1 if Post.where(dev: true).count > page_limit*@current_page + page_limit
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.user != current_user
      render json: { error: 'You are not authorized to edit this post.' }, status: :unauthorized
      return
    end

    @post.update(post_params)
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user != current_user
      render json: { error: 'You are not authorized to delete this post.' }, status: :unauthorized
      return
    end

    @post.destroy!
    redirect_to root_path
  end

  private def post_params
    params.require(:post).permit(:body, :dev)
  end

  private def page_limit
    20
  end
end
