class Author < ApplicationRecord
    has_many :books

    validates :email,
    format: { with: /(.+)@(.+)/, message: "Email invalid"  },
            uniqueness: { case_sensitive: false },
            length: { maximum: 254 }
    validates_presence_of :first_name, :last_name

    validate :valid_date_format         

    def valid_date_format
        if birth_date.present? 
            begin
            Date.parse(birth_date)
            rescue => error
                errors.add(:birth_date, error.message)
            end
        end
    end
end
