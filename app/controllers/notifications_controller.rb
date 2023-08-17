class NotificationsController < ApplicationController
  def index
    all = Notification.where(user: current_user).order(created_at: :desc)
    @notifications = all.limit(10)
  end

  def button
  end
end
