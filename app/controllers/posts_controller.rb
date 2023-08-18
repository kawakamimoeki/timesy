class PostsController < ApplicationController
  def trending
    if request.format == "text/html"
      set_cache_control_headers
    end
    @posts = Rails.cache.fetch("posts/trending", expires_in: 3.hours) do
      Post.trending
        .includes(:user, comments: :user, post_reactions: :user)
        .limit(5)
    end
  end

  def pin_button
    @post = Post.find(params[:id])
  end

  def main
    @post = Post.find(params[:id])
    @post_reaction = PostReaction.new
  end

  def form
    @post = Post.new
  end

  def index
    if request.format == "text/html"
      set_cache_control_headers
    end
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
    if request.format == "text/html"
      set_cache_control_headers
    end
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
    if request.format == "text/html"
      set_cache_control_headers
    end
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

  def show
    if request.format == "text/html"
      set_cache_control_headers
    end
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

  def pin_button
    @post = Post.find(params[:id])
  end

  def editor
    @post = Post.find(params[:id])
  end

  def form
    @post = Post.new
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

    purge_page(@post)
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

  private def purge_page(post)
    api_instance = Fastly::PurgeApi.new
    opts = {
        service_id: ENV['FASTLY_SERVICE_ID'],
        cached_url: "#{Site.origin}/posts/#{post.id}",
        fastly_soft_purge: 1
    }
    begin
      result = api_instance.purge_single_url(opts)
    rescue Fastly::ApiError => e
      Rails.logger.error("Exception when calling PurgeApi->purge_single_url: #{e}")
    end
  end

  private def post_params
    params.require(:post).permit(:body, images: [])
  end

  private def page_limit
    10
  end
end
