class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.virtual :textsearchable_index_col, type: :tsvector, as: "to_tsvector('english', body)", stored: true

      t.timestamps
    end

    add_index :posts, "to_tsvector('english', body)", using: :gin, name: 'posts_idx'
  end
end
