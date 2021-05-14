# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :provider
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.integer :contributions, default: 0
      t.integer :playlists, default: 0
      t.integer :friends, default: 0
      t.integer :groups, default: 0
      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
