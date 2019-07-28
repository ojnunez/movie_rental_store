# frozen_string_literal: true

class DeviseTokenAuthCreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table(:admins) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false

      ## User Info
      t.string :name
      t.string :nickname
      t.string :image
      t.string :email

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :admins, :email, unique: true
    add_index :admins, %i[uid provider], unique: true
    add_index :admins, :reset_password_token, unique: true
  end
end
