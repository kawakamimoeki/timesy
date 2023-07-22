class CreateEmailConfirmationSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :email_confirmation_sessions do |t|
      t.string :email, null: false
      t.datetime(:timeout_at, null: false)
      t.datetime(:expires_at, null: false)
      t.datetime(:claimed_at)
      t.string(:token, null: false)
  
      t.timestamps
    end
  end
end
