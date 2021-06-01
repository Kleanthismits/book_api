class Book < ApplicationRecord
    belongs_to :author
    belongs_to :publisher

    validates_presence_of :title, :creation_date, :isbn, :author
    validates_uniqueness_of :isbn

    validate :valid_date_format,
             :valid_isbn_format,
             :valid_isbn_length,
             :author_id_is_valid,
             :publisher_id_is_valid

    def valid_date_format
        if creation_date.present? 
            begin
                unless creation_date.is_a? Date
                    Date.parse(creation_date)
                end
            rescue => error
                errors.add(:creation_date, "#{error.message}: #{creation_date}")
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
            begin
                Author.find(author_id)
            rescue ActiveRecord::RecordNotFound => invalid
                errors.add(:author, "No author with such id: #{author_id}")
            end
        end
    end

    def publisher_id_is_valid
        if publisher_id.present?
            begin
                Publisher.find(publisher_id)
            rescue ActiveRecord::RecordNotFound => invalid
                errors.add(:publisher, "No publisher with such id: #{author_id}")
            end
        end
    end
end
