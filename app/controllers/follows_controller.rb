class FollowsController < ApplicationController
  def index
    @followees = current_user.followees
  end

  def create
    @followee = User.find_by(username: params[:username])
    Follow.create(follower: current_user, followee: @followee)
  end

  def destroy
    @followee = User.find_by(username: params[:username])
    follow = Follow.find_by(follower: current_user, followee: @followee)
    follow.destroy
  end
end
