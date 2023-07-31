class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title, null: false
      t.text :body
      t.string :codename, null: false, index: { unique: true }
      t.string :link
      t.references :user, null: false, foreign_key: true, index: false, type: :uuid

      t.timestamps
    end
  end
end
