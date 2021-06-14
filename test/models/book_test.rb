# rubocop:disable Metrics/ClassLength
require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def before_setup
    super
    @book = books(:one)
  end

  test 'should save valid book' do
    assert book.save
    assert_empty book.errors
  end

  test 'should not save book without title' do
    book.title = nil
    assert_not book.save
    assert_not_empty book.errors[:title]
    assert_equal [%(can't be blank)], book.errors[:title]
  end

  test 'should save book with no description' do
    book.description = nil
    assert book.save
    assert_empty book.errors
  end

  test 'should save book with blank description' do
    book.description = ''
    assert book.save
    assert_empty book.errors
  end

  test 'should save book without visibility status' do
    book = books(:two)
    assert book.save
    assert_empty book.errors
  end

  test 'should save if visibility status value is invalid' do
    book.visibility_status = 'yolo'
    assert book.save
    assert_empty book.errors[:visibility_status]
  end

  test 'should save visibility status as true in none is provided' do
    bok = Book.new(title: 'yolo', isbn: '12365649871023', author_id: 1, publisher_id: 1)
    bok.save
    assert_equal Book.last.visibility_status, true
  end

  test 'should save book without creation date' do
    book = books(:two)
    assert book.save
    assert_empty book.errors
  end

  test 'should not save if creation date value is invalid' do
    bdate = 'yolo'
    book.creation_date = bdate
    assert_not book.save
    assert_not_empty book.errors[:creation_date]
    assert_equal ["invalid date: #{bdate}"], book.errors[:creation_date]
  end

  test 'should not save if isbn is not provided' do
    book.isbn = nil
    assert_not book.save
    assert_not_empty book.errors[:isbn]
    assert_equal [%(can't be blank)], book.errors[:isbn]
  end

  test 'should not save if isbn is already taken' do
    book.isbn = books(:two).isbn
    assert_not book.save
    assert_not_empty book.errors[:isbn]
    assert_equal ['has already been taken'], book.errors[:isbn]
  end

  test 'should not save if isbn is not only numbers' do
    book.isbn = '111111111111a'
    assert_not book.save
    assert_not_empty book.errors[:isbn]
    assert_equal ["ISBN must contain only numbers: #{book.isbn}"], book.errors[:isbn]
  end

  test 'should not save if isbn is not of proper length' do
    book.isbn = '11'
    assert_not book.save
    assert_not_empty book.errors[:isbn]
    assert_equal ["ISBN must be 13 digits. Provided length: #{book.isbn.length}"], book.errors[:isbn]
  end

  test 'should not save if author id is not provided' do
    book.author_id = nil
    assert_not book.save
    assert_not_empty book.errors[:author_id]
    assert_equal [%(can't be blank)], book.errors[:author_id]
  end

  test 'should not save if author id not a number' do
    book.author_id = 'yolo'
    assert_not book.save
    assert_not_empty book.errors[:author_id]
    assert_equal ['is not a number'], book.errors[:author_id]
  end

  test 'should not save if author id not an integer' do
    book.author_id = 1.5
    assert_not book.save
    assert_not_empty book.errors[:author_id]
    assert_equal ['must be an integer'], book.errors[:author_id]
  end

  test 'should not save if an author with the author id provided does not exist' do
    book.author_id = 1000
    assert_not book.save
    assert_not_empty book.errors[:author_id]
    assert_equal ["No author with such id: #{book.author_id}"], book.errors[:author_id]
  end

  test 'should not save if publisher id not a number' do
    book.publisher_id = 'yolo'
    assert_not book.save
    assert_not_empty book.errors[:publisher_id]
    assert_equal ['is not a number'], book.errors[:publisher_id]
  end

  test 'should not save if publisher id not an integer' do
    book.publisher_id = 1.5
    assert_not book.save
    assert_not_empty book.errors[:publisher_id]
    assert_equal ['must be an integer'], book.errors[:publisher_id]
  end

  test 'should not save if a publisher with the publisher id provided does not exist' do
    book.publisher_id = 1000
    assert_not book.save
    assert_not_empty book.errors[:publisher_id]
    assert_equal ["No publisher with such id: #{book.publisher_id}"], book.errors[:publisher_id]
  end

  private

  attr_accessor :book
end
# rubocop:enable Metrics/ClassLength
