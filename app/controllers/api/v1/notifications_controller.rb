module Api
  module V1
    class NotificationsController < ApplicationController
      skip_forgery_protection

      def read
        notifications = current_user.notifications.unread
        notifications.update_all(read_at: Time.zone.now)
        render json: { success: true }  
      end
    end    
  end
end
