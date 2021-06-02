class Author < ApplicationRecord
    has_many :books

    validates :email,
    format: { with: /(.+)@(.+)/, message: "Email invalid"  },
            uniqueness: { case_sensitive: false },
            length: { maximum: 254 }
    validates_presence_of :first_name, :last_name, :email

    validate :valid_date_format?         

    def valid_date_format?
        date_input = self.birth_date_before_type_cast
        if date_input 

            return true if date_input == ''

            begin
            Date.parse(date_input)
            rescue => error
                errors.add(:birth_date, "invalid date: #{date_input}")
            end
        end
    end
end
