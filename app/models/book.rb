class Book < ApplicationRecord

    belongs_to :author, optional: true
    belongs_to :publisher, optional: true

    validates_presence_of :title, :isbn
    validates_uniqueness_of :isbn

    validate :valid_date_format,
             :valid_isbn_format,
             :valid_isbn_length,
             :author_id_is_valid,
             :publisher_id_is_valid

    private

    def valid_date_format
        if creation_date_before_type_cast.present? 
            begin
                Date.parse(creation_date_before_type_cast)
            rescue => error
                errors.add(:creation_date, "#{error.message}: #{creation_date_before_type_cast}")
            end
        end
    end

    def valid_isbn_length
        if isbn.present? && isbn.length != 13
            errors.add(:isbn, "ISBN must be 13 digits. Provided length: #{isbn.length}")
        end
    end

    def valid_isbn_format
        if isbn.present? && isbn !~ /\A\d+\Z/
            errors.add(:isbn, "ISBN must contain only numbers: #{isbn}")
        end
    end

    def author_id_is_valid
        if author_id.present?

            unless author_id_before_type_cast.is_a? Integer
                errors.add(:author, "Author id must be an integer")
                return false
            end 
                
            begin
                Author.find(author_id)
            rescue ActiveRecord::RecordNotFound => e
                errors.add(:author, "No author with such id: #{author_id}")
            end
        end
    end

    def publisher_id_is_valid
        if publisher_id.present?

            unless publisher_id_before_type_cast.is_a? Integer
                errors.add(:publisher, "Publisher id must be an integer")
                return false
            end 

            begin
                Publisher.find(publisher_id)
            rescue ActiveRecord::RecordNotFound => invalid
                errors.add(:publisher, "No publisher with such id: #{publisher_id}")
            end
        end
    end
end
