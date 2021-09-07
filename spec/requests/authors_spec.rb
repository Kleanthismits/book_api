# rubocop:disable Metrics/BlockLength
# rubocop:disable Metrics/ClassLength
require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  let!(:authors) { create_list(:author, 10) }
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Metrics/ClassLength
