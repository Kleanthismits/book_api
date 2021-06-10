require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  test 'create author if valid' do
    assert_difference 'Author.count' do
      post api_v1_authors_url, params: { author: {
        first_name: 'Test',
        last_name: 'Test',
        email: 'test@mail.com',
        birth_date: '1950-05-05'
      } }
    end
    assert_response :success
  end

  test 'do not create if author not valid' do
    assert_no_difference 'Author.count' do
      post api_v1_authors_url, params: { author: {
        email: 'test',
        birth_date: 'otinanai'
      } }
    end

    assert_response :unprocessable_entity
  end
end
