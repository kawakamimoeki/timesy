class CreateCommentReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_reactions, id: :uuid do |t|
      t.references :comment, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :body, null: false

      t.timestamps
    end
  end
end
