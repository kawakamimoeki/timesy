class AddWebhookUrlToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :webhook_url, :string
  end
end
