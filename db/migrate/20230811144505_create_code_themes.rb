class CreateCodeThemes < ActiveRecord::Migration[7.0]
  def change
    create_table :code_themes, id: :uuid do |t|
      t.string :name
      t.string :category

      t.timestamps
    end

    add_reference :users, :code_theme, type: :uuid, foreign_key: true
  end
end
