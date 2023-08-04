class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :subjectable, null: false, polymorphic: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.datetime :read_at

      t.timestamps
    end
  end
end
