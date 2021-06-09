# Represtantion of a book for BookController#index method
class BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        description: description(book),
        ISBN: book.isbn,
        author: author_name(book)
      }
    end
  end

  private

  attr_reader :books

  def description(book)
    book.description ? book.description.truncate(100) : nil
  end

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end
end
