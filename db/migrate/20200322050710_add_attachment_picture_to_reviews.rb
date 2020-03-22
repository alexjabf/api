# frozen_string_literal: true

# Add attachment to Reviews Migration
class AddAttachmentPictureToReviews < ActiveRecord::Migration[6.0]
  def self.up
    change_table :reviews do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :reviews, :picture
  end
end
