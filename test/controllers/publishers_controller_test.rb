require 'test_helper'

class PublishersControllerTest < ActionDispatch::IntegrationTest
  test 'create publisher if valid' do
    assert_difference 'Publisher.count' do
      post api_v1_publishers_url, params: { publisher: {
        name: 'Test',
        telephone: 'Test',
        address: 'test@mail.com'
      } }
    end
    assert_response :success
  end

  test 'do not create if publisher not valid' do
    assert_no_difference 'Publisher.count' do
      post api_v1_publishers_url, params: { publisher: {
        telephone: 'Test',
        address: 'test@mail.com'
      } }
    end

    assert_response :unprocessable_entity
  end
end
