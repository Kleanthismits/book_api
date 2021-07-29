# Representation of a book author when nested in a book json
class BookAuthorRepresenter
  def initialize(author)
    @author = author
  end

  def as_json
    {
      name: author_name,
      email: author.email,
      birth_date: birth_date
    }
  end

  private

  attr_reader :author

  def birth_date
    bdate = author.birth_date
    bdate ? "#{bdate.day.ordinalize} of #{Date::MONTHNAMES[bdate.month]} #{bdate.year}" : nil
  end

  def author_name
    "#{author.first_name} #{author.last_name}"
  end

  #test comment1
  #test comment2
  #test comment3
end
