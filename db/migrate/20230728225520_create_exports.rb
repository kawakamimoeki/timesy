class CreateExports < ActiveRecord::Migration[7.0]
  def change
    create_table :exports, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :state, null: false, default: "pending"

      t.timestamps
    end
  end
end
