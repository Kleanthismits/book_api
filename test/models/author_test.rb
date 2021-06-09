require 'test_helper'
#:nodoc:
class AuthorTest < ActiveSupport::TestCase
  def before_setup
    super
    @author = authors(:one)
  end

  test 'should save valid author' do
    assert author.save
    assert_empty author.errors
  end

  test 'should not save author without first name' do
    author.first_name = nil
    assert_not author.save
    assert_not_empty author.errors[:first_name]
    assert_equal [%(can't be blank)], author.errors[:first_name]
  end

  test 'should not save author with blank first name' do
    author.first_name = ''
    assert_not author.save
    assert_not_empty author.errors[:first_name]
    assert_equal [%(can't be blank)], author.errors[:first_name]
  end

  test 'should not save author without last name' do
    author.last_name = nil
    assert_not author.save
    assert_not_empty author.errors[:last_name]
    assert_equal [%(can't be blank)], author.errors[:last_name]
  end

  test 'should not save author with blank last name' do
    author.last_name = ''
    assert_not author.save
    assert_not_empty author.errors[:last_name]
    assert_equal [%(can't be blank)], author.errors[:last_name]
  end

  test 'should not save author without email' do
    author.email = nil
    assert_not author.save
    assert_not_empty author.errors[:email]
    assert_equal ['Invalid Email', %(can't be blank)], author.errors[:email]
  end

  test 'should not save author with invalid email' do
    author.email = 'yolo'
    assert_not author.save
    assert_not_empty author.errors[:email]
    assert_equal ['Invalid Email'], author.errors[:email]
  end

  test 'should save author without birth date' do
    author.birth_date = nil
    assert author.save
    assert_empty author.errors[:birth_date]
  end

  test 'should not save author with invalid birth date' do
    bdate = 'yolo'
    author.birth_date = bdate
    assert_not author.save
    assert_not_empty author.errors[:birth_date]
    assert_equal ["invalid date: #{bdate}"], author.errors[:birth_date]
  end

  private

  attr_accessor :author
end
