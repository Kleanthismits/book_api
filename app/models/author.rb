class Author < ApplicationRecord
  has_many :books

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Invalid Email' },
            uniqueness: { case_sensitive: false },
            length: { maximum: 254 }
  validates :first_name, :last_name, :email, presence: true

  validate :valid_date_format?

  def valid_date_format?
    return if birth_date_before_type_cast.blank? || birth_date_before_type_cast.is_a?(Date)

    begin
      Date.parse(birth_date_before_type_cast)
    rescue Date::Error
      errors.add(:birth_date, "invalid date: #{birth_date_before_type_cast}")
    end
  end
end
