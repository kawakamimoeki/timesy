class CreateCheerReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :cheer_reactions, id: :uuid do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :cheer, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
