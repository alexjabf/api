# frozen_string_literal: true

# Token Migration
class AddAuthenticationTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authentication_token, :string, limit: 30
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :image, :string
    add_index :users, :authentication_token, unique: true
  end
end
