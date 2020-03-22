# frozen_string_literal: true

# Book Model
class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
