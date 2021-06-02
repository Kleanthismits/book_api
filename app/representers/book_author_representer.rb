class BookAuthorRepresenter
    def initialize(author)
        @author = author
    end

    def as_json
        bdate = author.birth_date
        {
            name: "#{author.first_name} #{author.last_name}",
            email: author.email,
            birth_date: bdate ? "#{bdate.day.ordinalize} of #{Date::MONTHNAMES[bdate.month]} #{bdate.year}" : nil
        }
    end

    private 

    attr_reader :author
end