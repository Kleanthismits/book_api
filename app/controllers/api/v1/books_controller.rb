module Api
  module V1
    class BooksController < ApplicationController
      # @expenses = Expense.joins(:user).merge(User.order(:id)).paginate(:page => params[:page], :per_page => params[:per_page])

      def index
        books = Book.includes(:author).order('authors.last_name, books.id').where.not(publisher: nil)
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
        else
          render json: {errors: book.errors}, status: :unprocessable_entity
        end
      end

      def show
        begin
          book = Book.find(params[:id])
          render json: BookRepresenter.new(book).as_json
        rescue ActiveRecord::RecordNotFound
          render json: {errors: "No book with such id: #{params[:id]}"}
        end
        
      end

      def destroy
        begin
          Book.find(params[:id]).destroy!

          head :no_content
        rescue ActiveRecord::NotFound
          render json: {errors: "No book with such id: #{params[:id]}"}
        end

      end

      private

      def book_params
        params.require(:book).permit(:title, :description, :creation_date, :visibility_status, :isbn, :author_id, :publisher_id)
      end
    end  
  end
end
