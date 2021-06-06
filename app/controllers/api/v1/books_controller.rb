module Api
  module V1
    class BooksController < ApplicationController
      before_action :find_book

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
        @book.update(book_params)
        render json: BookRepresenter.new(@book).as_json
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "No book with such id: #{params[:id]}" }
      end

      def show
        render json: BookRepresenter.new(book_by_id).as_json
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "No book with such id: #{params[:id]}" }
      end

      def destroy
        @book.destroy!

        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "No book with such id: #{params[:id]}" }
      end

      private

      def book_params
        params.require(:book).permit(:title, :description, :creation_date, :visibility_status, :isbn, :author_id,
                                     :publisher_id)
      end

      def find_book
        @book = Book.find(params[:id])
      end
    end
  end
end
