class BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        description: book.description ? book.description.truncate(100) : nil,
        ISBN: book.isbn,
        author: "#{book.author.first_name} #{book.author.last_name}"
      }
    end
  end

  private

  attr_reader :books
end
