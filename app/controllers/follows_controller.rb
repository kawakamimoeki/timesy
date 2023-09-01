class FollowsController < ApplicationController
  def index
    @followees = current_user.followees
  end

  def create
    @followee = User.find_by(username: params[:username])
    follow = Follow.create(follower: current_user, followee: @followee)
    @notification = Notification.create(user: @followee, subjectable: follow)
    @notification.broadcast_prepend_to("notifications-for-#{@followee.id}")
  end

  def destroy
    @followee = User.find_by(username: params[:username])
    follow = Follow.find_by(follower: current_user, followee: @followee)
    follow.destroy
  end
end
