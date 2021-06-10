require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  def before_setup
    super
    @publisher = publishers(:one)
  end

  test 'should save valid publisher' do
    assert publisher.save
    assert_empty publisher.errors
  end

  test 'should not save publisher without name' do
    publisher.name = nil
    assert_not publisher.save
    assert_not_empty publisher.errors[:name]
    assert_equal [%(can't be blank)], publisher.errors[:name]
  end

  private

  attr_accessor :publisher
end
