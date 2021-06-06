class BookPublisherPresenter
  def initialize(publisher)
    @publisher = publisher
  end

  def as_json
    {
      name: publisher.name,
      address: publisher.address || nil
    }
  end

  private

  attr_reader :publisher
end
