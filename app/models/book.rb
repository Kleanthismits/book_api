#:nodoc:
class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :publisher, optional: true

  validates :title, :isbn, :author_id, presence: true
  validates :isbn, uniqueness: true
  validates :author_id, numericality: { only_integer: true }, if: -> { !author_id.nil? }
  validates :publisher_id, numericality: { only_integer: true }, allow_nil: true

  validate :valid_date_format,
           :valid_isbn_format,
           :valid_isbn_length,
           :author_id_is_valid,
           :publisher_id_is_valid

  private

  def valid_date_format
    return if creation_date_before_type_cast.blank? || creation_date_before_type_cast.is_a?(Date)

    begin
      Date.parse(creation_date_before_type_cast)
    rescue Date::Error
      errors.add(:creation_date, "invalid date: #{creation_date_before_type_cast}")
    end
  end

  def valid_isbn_length
    errors.add(:isbn, "ISBN must be 13 digits. Provided length: #{isbn.length}") if isbn.present? && isbn.length != 13
  end

  def valid_isbn_format
    errors.add(:isbn, "ISBN must contain only numbers: #{isbn}") if isbn.present? && isbn !~ /\A\d+\Z/
  end

  def author_id_is_valid
    return if author_id.blank? || author_id.nil? || !author_id_before_type_cast.is_a?(Integer)

    begin
      Author.find(author_id)
    rescue ActiveRecord::RecordNotFound
      errors.add(:author_id, "No author with such id: #{author_id}")
    end
  end

  def publisher_id_is_valid
    return if publisher_id.blank?

    begin
      Publisher.find(publisher_id)
    rescue ActiveRecord::RecordNotFound
      errors.add(:publisher_id, "No publisher with such id: #{publisher_id}")
    end
  end
end
