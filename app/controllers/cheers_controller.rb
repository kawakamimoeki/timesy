class CheersController < ApplicationController
  def form
    @post = Post.find(params[:post_id])
    @cheer = Cheer.new
  end

  def index
    @post = Post.find(params[:post_id])
    @current_page = params[:page].to_i

    @cheers = @post.cheers.offset(page_limit*@current_page)
      .includes(:user, cheer_reactions: :user)
      .oldest
  end

  def create
    @post = Post.find(params[:post_id])
    @cheer = Cheer.create!(cheer_params.merge(user: current_user, post: @post))
    @cheer.images.attach(cheer_params[:images]) if cheer_params[:images].present?

    if @post.user != current_user
      @notification = Notification.create(user: @post.user, subjectable: @cheer)
      @notification.broadcast_prepend_to("notifications-for-#{@post.user.id}")
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @cheer = Cheer.find(params[:id])

    if @cheer.user != current_user
      render json: { error: 'You are not authorized to delete this cheer.' }, status: :unauthorized
      return
    end

    @cheer.destroy!
    @cheer.broadcast_remove_to("cheers-of-#{params[:post_id]}")
  end

  def update
    @post = Post.find(params[:post_id])
    @cheer = Cheer.find(params[:id])

    if @cheer.user != current_user
      render json: { error: 'You are not authorized to edit this cheer.' }, status: :unauthorized
      return
    end

    @cheer.update!(cheer_params)
    @cheer.images.attach(cheer_params[:images]) if cheer_params[:images].present?
  end

  def editor
    @cheer = Cheer.find(params[:id])
  end

  def count
    @post = Post.find(params[:post_id])
    @count = @post.cheers.count
  end

  private def cheer_params
    params.require(:cheer).permit(:body, images: [])
  end

  private def page_limit
    10
  end
end
