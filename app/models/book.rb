class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :publisher, optional: true

  validates :title, :isbn, presence: true
  validates :isbn, uniqueness: true
  validates :author_id, numericality: { only_integer: true }
  validates :publisher_id, numericality: { only_integer: true }, allow_nil: true

  validate :valid_date_format,
           :valid_isbn_format,
           :valid_isbn_length,
           :author_id_is_valid,
           :publisher_id_is_valid

  validate :valid_isbn_format, if: :isbnn_changed?, on: :update

  private

  def valid_date_format
    return if creation_date_before_type_cast.blank? || creation_date_before_type_cast.is_a?(Date)

    begin
      Date.parse(creation_date_before_type_cast)
    rescue Date::Error
      errors.add(:creation_date, "invalid date: #{date_input}")
    end
  end

  def valid_isbn_length
    errors.add(:isbn, "ISBN must be 13 digits. Provided length: #{isbn.length}") if isbn.present? && isbn.length != 13
  end

  def valid_isbn_format
    errors.add(:isbn, "ISBN must contain only numbers: #{isbn}") if isbn.present? && isbn !~ /\A\d+\Z/
  end

  def author_id_is_valid
    return if author_id.blank?

    begin
      Author.find(author_id)
    rescue ActiveRecord::RecordNotFound => e
      errors.add(:author, "No author with such id: #{author_id}")
    end
  end

  def publisher_id_is_valid
    return if publisher_id.blank?

    begin
      Publisher.find(publisher_id)
    rescue ActiveRecord::RecordNotFound => e
      errors.add(:publisher, "No publisher with such id: #{publisher_id}")
    end
  end

  def isbnn_changed?
    binding.pry

  end
end
