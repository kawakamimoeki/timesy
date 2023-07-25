class AddDevColumnToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :dev, :boolean, default: false
  end
end
