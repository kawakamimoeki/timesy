class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_column :posts, :category_id, :integer
    add_index :posts, :category_id
  end
end
