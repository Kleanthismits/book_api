require 'rails_helper'

shared_examples 'failure message' do
  it 'returns failure message' do
    expect(json['errors']).to match(message)
  end
end
