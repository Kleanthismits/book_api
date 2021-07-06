require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let!(:publishers) { create_list(:publisher, 10) }
  let!(:books) { create_list(:book, 30) }
  let(:book_id) { books.first.id }
  let(:base_path) { '/api/v1/' }

  # Test suite for GET /books
  describe 'GET /books' do
    let(:expected) { Book.published.size }

    # make HTTP get request before each example
    before { get "#{base_path}books" }

    it 'returns books' do
      # 'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty

      expect(json.size).to eq(expected)
    end
  end

  # Test suite for GET /books/:id
  describe 'GET /books/:id' do
    let(:book) { Book.find(book_id) }
    before { get "#{base_path}/books/#{book_id}" }

    context 'when the record exists' do
      it 'returns the book' do
        expect(json).not_to be_empty
        expect(json['title']).to eq(book.title)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:book_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['errors']).to match(/No book with such id: #{book_id}/)
      end
    end
  end

  # Test suite for PUT /books/:id
  describe 'Put /books/:id' do
    let(:book) { Book.find(book_id) }
    let(:isbn) { '9879879879879' }
    before { put "#{base_path}/books/#{book_id}", params: { book: { isbn: isbn } } }

    context 'when the record does not exist' do
      let(:book_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['errors']).to match(/No book with such id: #{book_id}/)
      end
    end

    context 'when the record exists' do
      context 'when the request is valid' do
        it 'updates a book' do
          expect(json['ISBN']).to eq(isbn)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns the book' do
          expect(json).not_to be_empty
          expect(json['title']).to eq(book.title)
        end
      end

      context 'when the isbn is not valid' do
        let(:isbn) { '' }
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message for missing isbn' do
          expect(json['errors']['isbn']).to include("can't be blank")
        end
      end
    end
  end

  # Test suite for POST /books
  describe 'Post /books' do
    # valid payload
    let(:valid_attributes) do
      author = Author.first
      { book: { title: 'Learn Elm', isbn: '1234567891230', author_id: author.id } }
    end

    context 'when the request is valid' do
      before { post "#{base_path}books", params: valid_attributes }

      it 'creates a book' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "#{base_path}books", params: { book: { title: 'Foobar' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message for missing isbn' do
        expect(json['errors']['isbn']).to include("can't be blank")
      end

      it 'returns a validation failure message for missing author_id' do
        expect(json['errors']['author_id']).to include("can't be blank")
      end
    end
  end

  # Test suite for PUT /books/:id
  describe 'DELETE /books/:id' do
    context 'when the record exists' do
      it 'returns status code 204' do
        expect { delete "#{base_path}/books/#{book_id}" }.to change(Book, :count).by(-1)
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      let(:book_id) { 1000 }
      before { delete "#{base_path}/books/#{book_id}" }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['errors']).to match(/No book with such id: #{book_id}/)
      end
    end
  end
end
