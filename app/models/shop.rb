class Shop < ApplicationRecord
  validates :name, presence: true

  has_many :stocks
  has_many :books, through: :stocks

  class BookAbsentError < StandardError; end
  class TooLittleCopiesError < StandardError; end

  def sell(book_id, copies_number = 1)
    copies_number = copies_number.to_i
    raise TooLittleCopiesError, I18n.t('errors.models.shop.zero_copies') if copies_number.zero?

    book_in_stock = books.find_by(id: book_id)

    stock = Stock.find_by(book: book_in_stock, shop: self)

    raise BookAbsentError, I18n.t('errors.models.shop.has_no_book', id: book_id) unless book_in_stock.present?
    raise TooLittleCopiesError, I18n.t('errors.models.shop.too_little_copies', copies_number: copies_number, title: book_in_stock.title) if copies_number > stock.copies_in_stock

    with_lock do
      Shop.transaction do
        stock.decrement_copies(copies_number)
        stock.increment_books_sold(copies_number)
      end
    end

    book_in_stock
  end

  def buy(book_id)
    book_in_stock = books.find_by(id: book_id)

    if book_in_stock.present?
      Stock.find_by!(book: book_in_stock, shop: self).increment_copies
    else
      books << Book.find(book_id)
    end
  end
end
