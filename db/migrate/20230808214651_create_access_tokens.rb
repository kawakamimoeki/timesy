class CreateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.string :token, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
