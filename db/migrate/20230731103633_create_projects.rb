class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title, null: false
      t.text :description
      t.string :codename, null: false
      t.references :user, null: false, foreign_key: true, index: false, type: :uuid

      t.timestamps

      t.index [:user_id, :codename], unique: true
    end
  end
end
