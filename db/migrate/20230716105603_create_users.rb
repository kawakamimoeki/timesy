class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, required: true, index: { unique: true }
      t.string :username, required: true, index: { unique: true }
      t.string :name, required: true
      t.text :bio
      t.string :github
      t.string :twitter
      t.string :website

      t.timestamps
    end
  end
end
