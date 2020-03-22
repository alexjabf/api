# frozen_string_literal: true

# Book Serializer
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :image,
             :content_rating_of_book, :recommend_rating_of_book, :total_reviews,
             :total_uniq_users_who_reviwed, :average_rating_of_book,
             :total_reviews
  has_many :reviews

  def average_rating_of_book
    object.reviews.count.zero? ? 0 : object.reviews.average(:average_rating).round(2)
  end

  def content_rating_of_book
    object.reviews.count.zero? ? 0 : object.reviews.average(:content_rating).round(2)
  end

  def recommend_rating_of_book
    object.reviews.count.zero? ? 0 : object.reviews.average(:recommend_rating).round(2)
  end

  def total_reviews
    object.reviews_count
  end

  def total_uniq_users_who_reviwed
    object.reviews.pluck(:user_id).uniq.count
  end
end
