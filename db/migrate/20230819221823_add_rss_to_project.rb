class AddRssToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :rss, :boolean, default: false
  end
end
