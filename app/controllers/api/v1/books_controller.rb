# frozen_string_literal: true

module Api
  module V1
    # Books Controller
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show destroy update]
      before_action :book_params, only: %i[create update]

      def index
        @books = Book.all.includes(:reviews)
        books_serializer = parse_json(@books)
        json_response('Index Books', true, { books: books_serializer }, :ok)
      end

      def show
        book_serializer = parse_json(@book)
        json_response('Book', true, { book: book_serializer }, :ok)
      end

      def create
        @book = Book.new(book_params)
        if @book.save
          json_response('Book successfully created', true, { books: @book }, :ok)
        else
          json_response(@book.errors, false, {}, :unauthorized)
        end
      end

      def update
        if @book.update_attributes(book_params)
          json_response('Book successfully updated', true, { books: @book }, :ok)
        else
          json_response(@book.errors, false, {}, :unauthorized)
        end
      end

      def destroy
        @book.destroy
        json_response('Book successfully destroyed', true, {}, :ok)
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :image)
      end

      def set_book
        @book = Book.find_by id: params[:id]
        return if @book.present?

        json_response("Can not find book with id #{params[:id]}",
                      false, {}, :not_found)
      end
    end
  end
end
