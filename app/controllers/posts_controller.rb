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
    @post_reaction = PostReaction.new
    @current_page = params[:page].to_i

    @posts = Post.offset(page_limit*@current_page).includes(:user, comments: :user, post_reactions: :user).latest.limit(page_limit)
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
  end

  def show
    @post = Post.includes(comments: :user).find_by(id: params[:id])
    @post_reaction = PostReaction.new
    @comment_reaction = CommentReaction.new
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
    @post.images.attach(post_params[:images]) if post_params[:images].present?
    @current_page = params[:page].to_i

    @posts = Post.offset(page_limit*@current_page).includes(:user, comments: :user).latest.limit(page_limit)
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
  end

  def update
    @post = Post.find(params[:id])

    if @post.user != current_user
      render json: { error: 'You are not authorized to edit this post.' }, status: :unauthorized
      return
    end

    @post.update(post_params)
    @post.images.attach(post_params[:images]) if post_params[:images].present?
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user != current_user
      render json: { error: 'You are not authorized to delete this post.' }, status: :unauthorized
      return
    end

    @post.destroy!
    redirect_to root_path, status: 303
  end

  private def post_params
    params.require(:post).permit(:body, images: [])
  end

  private def page_limit
    20
  end
end
