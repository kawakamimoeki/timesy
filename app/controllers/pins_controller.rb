class PinsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    pin = Pin.create(post: @post, user: current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    pin = Pin.find(params[:id])
    pin.destroy
  end
end
