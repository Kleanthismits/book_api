#:nodoc:
class Book < ApplicationRecord
  include BookValidator

  belongs_to :author, optional: true
  belongs_to :publisher, optional: true

  scope :published, -> { where.not(publisher: nil) }
  # order by author last name ascending and book id descending
  scope :ordered_by_author_last_name_book_id, -> { order('authors.last_name, books.id desc') }
  scope :for_books_representation, lambda {
                                     select(:title,
                                            :description,
                                            :isbn,
                                            :author_id,
                                            'authors.first_name',
                                            'authors.last_name')
                                       .includes(:author)
                                   }

  delegate :author_full_name, to: :author

  # returns the truncated description if desciption has more than 100 characters
  def truncate_description
    description ? description.truncate(100) : nil
  end
end
