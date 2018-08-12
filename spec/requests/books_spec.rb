require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  let!(:publisher) { create(:publisher) }
  let!(:book) { create(:book, publisher: publisher) }
  let!(:shop) { create(:shop) }

  describe 'PATCH /api/v1/shops/:shop_id/books/:id' do
    let(:patch_attributes) { { book: { copies: 2 } } }

    context 'when shop baught less than it tries to sell' do
      before do
        shop.buy(book.id)

        patch "/api/v1/shops/#{shop.id}/books/#{book.id}", params: patch_attributes
      end

      it 'returns error object with reason description' do
        expect(JSON.parse(response.body))
          .to eq(
            'error' => I18n.t(
              'errors.models.shop.too_little_copies',
              copies_number: patch_attributes.dig(:book, :copies),
              title: book.title
            )
          )
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when shop baught more than it tries to sell' do
      before do
        2.times { shop.buy(book.id) }

        patch "/api/v1/shops/#{shop.id}/books/#{book.id}", params: patch_attributes
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
