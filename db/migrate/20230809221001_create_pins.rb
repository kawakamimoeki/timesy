class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, index: true
      t.references :post, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
