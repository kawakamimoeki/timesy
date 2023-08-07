module Api
  module V1
    class NotificationsController < ApplicationController
      def read
        notifications = current_user.notifications.unread.where(id: params[:ids])
        notifications.update_all(read_at: Time.zone.now)
        render json: { success: true }  
      end
    end    
  end
end
