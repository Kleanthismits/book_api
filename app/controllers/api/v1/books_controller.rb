module Api
  module V1
    #:nodoc:
    class BooksController < ApplicationController
      before_action :find_book, except: %i[create index]

      def index
        books = Book.includes(:author).order('authors.last_name, books.id desc').where.not(publisher: nil)
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        book = Book.new(book_params)
        if book.save
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: { errors: book.errors }, status: :unprocessable_entity
        end
      end

      def update
        @book.assign_attributes(book_params)

        if @book.valid?
          @book.update(book_params)
          render json: BookRepresenter.new(@book).as_json
        else
          render json: { errors: @book.errors }, status: :unprocessable_entity
        end
      end

      def show
        render json: BookRepresenter.new(@book).as_json
      end

      def destroy
        @book.destroy
        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(:title, :description, :creation_date, :visibility_status, :isbn, :author_id,
                                     :publisher_id)
      end

      def find_book
        @book = Book.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "No book with such id: #{params[:id]}" }, status: :not_found
      end
    end
  end
end
