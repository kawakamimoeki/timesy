class AddProjectIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :project, null: false, foreign_key: true, type: :uuid
  end
end
