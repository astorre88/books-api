require 'rails_helper'

describe SellBook do
  let(:shop) { create(:shop) }
  let(:book) { create(:book, publisher: create(:publisher)) }
  subject do
    described_class.call(
      shop_id: shop.id,
      book_id: book.id,
      copies_number: copies_number
    )
  end

  context 'when copies_number equals zero' do
    let(:copies_number) { 0 }

    before { shop.buy(book.id) }

    it 'returns error object' do
      expect(subject).to eq [:error, I18n.t('errors.models.shop.zero_copies')]
    end

    it 'does not change copies_in_stock' do
      expect { subject }
        .not_to change { shop.stocks.find_by(book: book).copies_in_stock }
    end

    it 'does not change books_sold_count' do
      expect { subject }
        .not_to change { shop.stocks.find_by(book: book).books_sold_count }
    end
  end

  context 'when shop has no book' do
    let(:copies_number) { 1 }

    it 'returns error object' do
      expect(subject)
        .to eq [
          :error,
          I18n.t(
            'errors.models.shop.has_no_book',
            id: book.id
          )
        ]
    end
  end

  context 'when copies_number is more than copies_in_stock' do
    let(:copies_number) { 2 }

    before { shop.buy(book.id) }

    it 'returns error object' do
      expect(subject)
        .to eq [
          :error,
          I18n.t(
            'errors.models.shop.too_little_copies',
            copies_number: copies_number,
            title: book.title
          )
        ]
    end
  end

  context 'when copies_number is less than copies_in_stock' do
    let(:copies_number) { 1 }

    before { shop.buy(book.id) }

    it 'changes copies_in_stock' do
      expect { subject }
        .to change { shop.stocks.find_by(book: book).copies_in_stock }
        .from(1).to(0)
    end

    it 'changes books_sold_count' do
      expect { subject }
        .to change { shop.stocks.find_by(book: book).books_sold_count }
        .from(0).to(1)
    end

    it 'returns success object' do
      expect(subject).to eq [:ok, book]
    end
  end
end
