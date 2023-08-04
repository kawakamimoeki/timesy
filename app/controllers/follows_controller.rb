class FollowsController < ApplicationController
  def index
    @followees = current_user.followees
  end

  def create
    @followee = User.find_by(username: params[:username])
    Follow.create(follower: current_user, followee: @followee)
    WebhookJob.perform_later(
      distination: @followee.user.webhook_url,
      type: "follow",
      subject: Webhooks::FollowSerializer.render_as_hash(follow),
      message: I18n.t("webhooks.follow", user: current_user.name),
      url: user_url(@current_user.username),
    )
  end

  def destroy
    @followee = User.find_by(username: params[:username])
    follow = Follow.find_by(follower: current_user, followee: @followee)
    follow.destroy
  end
end
