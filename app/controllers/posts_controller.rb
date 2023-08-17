class PostsController < ApplicationController
  def trending
    @posts = Rails.cache.fetch("posts/trending", expires_in: 3.hours) do
      Post.trending
        .includes(:user, comments: :user, post_reactions: :user)
        .limit(5)
    end
  end

  def index
    @post = Post.new
    @post_reaction = PostReaction.new
    @current_page = params[:page].to_i

    if current_user
      @posts = Post.offset(page_limit*@current_page)
        .includes(:user, comments: :user, post_reactions: :user)
        .latest
        .limit(page_limit)
        .following(current_user)
      @next_page = @current_page + 1 if Post.following(current_user).count > page_limit*@current_page + page_limit
    else
      @posts = Rails.cache.fetch("posts/latest/pages/#{@current_page}/per/#{page_limit}", expires_in: 10.minutes) do
        Post.offset(page_limit*@current_page)
          .includes(:user, comments: :user, post_reactions: :user)
          .latest
          .limit(page_limit)
      end
      @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
    end
  end

  def latest
    @post = Post.new
    @post_reaction = PostReaction.new
    @current_page = params[:page].to_i

    @posts = Rails.cache.fetch("posts/latest/pages/#{@current_page}/per/#{page_limit}", expires_in: 10.minutes) do
      Post.offset(page_limit*@current_page)
        .includes(:user, comments: :user, post_reactions: :user)
        .latest
        .limit(page_limit)
    end
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
    render :index
  end

  def pinned
    @post = Post.new
    @post_reaction = PostReaction.new
    @current_page = params[:page].to_i

    all = Post.offset(page_limit*@current_page)
      .includes(:user, comments: :user, post_reactions: :user)
      .pinned_by(current_user)
      .latest
    @posts = all.limit(params[:limit] || page_limit)
    @next_page = @current_page + 1 if all.count > page_limit*@current_page + page_limit
  end

  def thread
    @post = Post.includes(comments: :user).find_by(id: params[:id])
    @post_reaction = PostReaction.new
    @comment_reaction = CommentReaction.new
    if @post.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
    @comment = Comment.new
    @current_page = params[:page].to_i

    @comments = @post.comments.offset(page_limit*@current_page)
      .includes(:user, comment_reactions: :user)
      .latest
      .limit(page_limit)
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
    @comment = Comment.new
  end

  def show
    @post = Post.includes(comments: :user).find_by(id: params[:id])
    @post_reaction = PostReaction.new
    @comment_reaction = CommentReaction.new
    if @post.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
    @current_page = params[:page].to_i

    @comments = @post.comments.offset(page_limit*@current_page)
      .includes(:user, comment_reactions: :user)
      .latest
      .limit(page_limit)
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
    @comment = Comment.new
  end

  def new
    @post = Post.new
    render :new, layout: 'editor'
  end

  def create
    @post = Post.create(post_params.merge(user: current_user))
    @post.attach_projects!
    @post.broadcast_prepend_to("posts")
  end

  def update
    @post = Post.find(params[:id])

    if @post.user != current_user
      render json: { error: 'You are not authorized to edit this post.' }, status: :unauthorized
      return
    end

    @post.update(post_params)
    @post.attach_projects!
    @post.broadcast_remove_to("posts")
    @post.broadcast_prepend_to("posts")
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
    10
  end
end
