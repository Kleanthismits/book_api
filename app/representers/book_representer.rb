# Representation of a book for BookController#create method
class BookRepresenter
  def initialize(book)
    @book = book
  end

  def as_json
    {
      title: book.title,
      description: book.description || nil,
      ISBN: book.isbn,
      creation_date: book.creation_date,
      author: author,
      publisher: publisher
    }
  end

  private

  attr_reader :book

  def author
    BookAuthorRepresenter.new(book.author).as_json
  end

  def publisher
    book.publisher ? BookPublisherPresenter.new(book.publisher).as_json : nil
  end
end
