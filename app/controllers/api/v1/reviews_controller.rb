# frozen_string_literal: true

module Api
  module V1
    # Reviews Controller
    class ReviewsController < ApplicationController
      before_action :set_book, only: %i[index create]
      before_action :set_review, only: %i[show destroy update]
      before_action :review_params, only: %i[create update]
      before_action :verify_correct_user, only: %i[show update destroy]
      # before_action authenticate_with_token!, only: [:create, :update, :destroy]

      def index
        @reviews = @book.reviews.includes(:user)
        reviews_serializer = parse_json(@reviews)
        json_response('Index Reviews', true, { reviews: reviews_serializer }, :ok)
      end

      def show
        review_serializer = parse_json(@review)
        json_response('Review', true, { review: review_serializer }, :ok)
      end

      def create
        @review = Review.new(review_params)
        @review.user_id = current_user.id
        @review.book_id = @book.id
        if @review.save
          json_response('Review successfully created', true, { reviews: @review }, :ok)
        else
          json_response(@review.errors, false, {}, :unauthorized)
        end
      end

      def update
        if @review.update_attributes(review_params)
          json_response('Review successfully updated', true, { reviews: @review }, :ok)
        else
          json_response(@review.errors, false, {}, :unauthorized)
        end
      end

      def destroy
        @review.destroy
        json_response('Review successfully destroyed', true, {}, :ok)
      end

      private

      def review_params
        params.require(:review).permit(:book_id, :title, :content_rating,
                                       :recommend_rating, :image_review)
      end

      def set_book
        @book = Book.find_by id: params[:book_id]
        return if @book.present?

        json_response("Can not find book with id #{params[:id]}",
                      false, {}, :not_found)
      end

      def set_review
        @review = Review.find_by id: params[:id]
        return if @review.present?

        json_response("Can not find review with id #{params[:id]}",
                      false, {}, :not_found)
      end

      def verify_correct_user
        return if correct_user(@review.user)

        json_response("You don't have permission to update this review",
                      false, {}, :unauthorized)
      end
    end
  end
end
