# Represetantion of a book for BookController#index method
class BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      {
        title: book.title,
        description: book.truncate_description,
        ISBN: book.isbn,
        author: book.author_full_name
      }
    end
  end

  private

  attr_reader :books
end
