class RemoveProjectIdFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :posts, :project, foreign_key: true, type: :uuid
  end
end
