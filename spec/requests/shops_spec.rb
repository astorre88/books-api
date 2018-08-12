require 'rails_helper'

RSpec.describe 'Shops API', type: :request do
  let!(:publisher) { create(:publisher) }
  let!(:publisher2) { create(:publisher) }

  let!(:book) { create(:book, publisher: publisher) }
  let!(:book2) { create(:book, publisher: publisher) }
  let!(:book3) { create(:book, publisher: publisher) }

  let!(:book4) { create(:book, publisher: publisher2) }
  let!(:book5) { create(:book, publisher: publisher2) }
  let!(:book6) { create(:book, publisher: publisher2) }

  let!(:shop) { create(:shop) }
  let!(:shop2) { create(:shop) }
  let!(:shop3) { create(:shop) }

  describe 'GET /api/v1/publishers/:publisher_id/shops' do
    context 'when the shop selling at least one book of described publisher exists' do
      before do
        5.times do
          shop.buy(book.id)
          shop2.buy(book2.id)
          shop3.buy(book4.id)
        end
        2.times { shop2.buy(book3.id) }
        3.times { shop.sell(book.id) }
        2.times { shop2.sell(book2.id) }
        2.times { shop2.sell(book3.id) }
        shop3.sell(book4.id)

        get "/api/v1/publishers/#{publisher.id}/shops"
      end

      it 'returns data in descendent order by books_sold_count' do
        expect(JSON.parse(response.body).map { |s| s['books_sold_count'] })
          .to eq [4, 3]
      end

      it "returns the list of shops only sold publisher's books" do
        expect(JSON.parse(response.body)).to eq [
          {
            'id'                => shop2.id,
            'name'              => shop2.name,
            'books_sold_count'  => 4,
            'books_in_stock'    => [
              {
                'id'              => book2.id,
                'title'           => book2.title,
                'copies_in_stock' => 3
              },
              {
                'id'              => book3.id,
                'title'           => book3.title,
                'copies_in_stock' => 0
              }
            ]
          },
          {
            'id'                => shop.id,
            'name'              => shop.name,
            'books_sold_count'  => 3,
            'books_in_stock'    => [
              {
                'id'              => book.id,
                'title'           => book.title,
                'copies_in_stock' => 2
              }
            ]
          }
        ]
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the shop selling at least one book of described publisher does not exist' do
      before { get "/api/v1/publishers/#{publisher.id}/shops" }

      it 'returns the empty list' do
        expect(JSON.parse(response.body)).to eq []
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
