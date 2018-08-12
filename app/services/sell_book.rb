class SellBook
  class << self
    def call(shop_id:, book_id:, copies_number:)
      book =
        Shop.find(shop_id)
            .sell(
              book_id,
              copies_number
            )
      [:ok, book]
    rescue Shop::BookAbsentError, Shop::TooLittleCopiesError => e
      Rails.logger.error e.to_s
      [:error, e.to_s]
    end
  end
end
