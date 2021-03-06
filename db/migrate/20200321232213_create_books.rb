# frozen_string_literal: true

# Books Migration
class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :image
      t.string :author
      t.string :title

      t.timestamps
    end
  end
end
