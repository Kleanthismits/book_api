require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_v1_books_url
    assert_response :success
  end

  test 'only books with publisher are shown' do
    expected_size = Book.where.not(publisher: nil).size
    get api_v1_books_url
    assert_equal JSON.parse(@response.body).size, expected_size
  end

  test 'create book if valid' do
    assert_difference 'Book.count' do
      post api_v1_books_url, params: { book: {
        title: 'test',
        description: 'test',
        isbn: '1234567891230',
        creation_date: '2010-05-05',
        author_id: authors(:one).id,
        publisher_id: publishers(:one).id
      } }
    end
    assert_response :success
  end

  test 'do not create if book not valid' do
    assert_no_difference 'Book.count' do
      post api_v1_books_url, params: { book: {
        description: 'test',
        creation_date: '2010-05-05',
        author_id: authors(:one).id,
        publisher_id: publishers(:one).id
      } }
    end

    assert_response :unprocessable_entity
  end

  test 'should get show book' do
    get "#{api_v1_books_url}/#{books(:one).id}"
    assert_response :success
  end

  test 'should get not found response for not existing id' do
    get "#{api_v1_books_url}/1000"
    assert_response :not_found
  end

  test 'delete book with valid id' do
    assert_difference 'Book.count', -1 do
      delete "#{api_v1_books_url}/#{books(:one).id}"
    end

    assert_response :no_content
  end

  test 'should get not found response for delete with non existing id' do
    delete "#{api_v1_books_url}/1000"
    assert_response :not_found
  end

  test 'update book if params are valid' do
    new_title = 'new_test'
    put "#{api_v1_books_url}/#{books(:one).id}",
        params: { book: {
          title: new_title
        } }
    assert_response :success
    assert_equal Book.find(books(:one).id).title, new_title
  end

  test 'do not update if params are invalid' do
    put "#{api_v1_books_url}/#{books(:one).id}",
        params: { book: {
          creation_date: 'otinanai',
          author_id: 1000,
          publisher_id: 1000
        } }
    assert_response :unprocessable_entity
    assert_equal Book.find(books(:one).id).author_id, books(:one).author_id
  end

  test 'should get not found when updating book with non existing id' do
    put "#{api_v1_books_url}/1000",
        params: { book: {
          title: 'new_test'
        } }
    assert_response :not_found
  end
end
