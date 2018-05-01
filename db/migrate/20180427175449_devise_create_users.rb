# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name,               null: false
      t.string :image,              null: true
      t.string :email,              null: false
      t.string :encrypted_password, null: false
      t.string :provider,           null: false
      t.string :uid,                null: false
      t.string :token,              null: false
      t.string :refresh_token,      null: false
      t.integer :expires_at,        null: false
      t.boolean :expires,           null: false
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
