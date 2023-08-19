class AddGoogleAnalyticsTrackingIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :google_analytics_tracking_id, :string
  end
end
