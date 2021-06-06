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
      author: BookAuthorRepresenter.new(book.author).as_json,
      publisher: book.publisher ? BookPublisherPresenter.new(book.publisher).as_json : nil
    }
  end

  private

  attr_reader :book
end
