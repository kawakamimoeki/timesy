class CreatePostsProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_projects, id: :uuid do |t|
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.references :project, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
