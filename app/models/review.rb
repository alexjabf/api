# frozen_string_literal: true

# Review Model
class Review < ApplicationRecord
  before_validation :parse_image
  before_save :calculate_average_rating
  belongs_to :user
  belongs_to :book
  counter_culture :book
  counter_culture :user

  attr_accessor :image_review

  has_attached_file :picture, style: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture

  private

  def parse_image
    image = Paperclip.io_adapters.for(image_review, { hash_digest: Digest::Base64 })
    image.original_filename = 'review_image.jpeg'
    self.picture = image
  end

  def calculate_average_rating
    self.average_rating =
      ((content_rating.to_f + recommend_rating.to_f) / 2).round(1)
  end
end
