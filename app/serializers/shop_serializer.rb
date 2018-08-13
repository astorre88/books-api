class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :books_sold_count

  has_many :books_in_stock

  def books_sold_count
    Stock.books_sold_count(@instance_options[:publisher_id], object.id)
  end

  def books_in_stock
    object.books
          .where(publisher_id: @instance_options[:publisher_id])
          .map do |book|
      {
        id: book.id,
        title: book.title,
        copies_in_stock: Stock.copies_in_stock(book.id, object.id)
      }
    end
  end
end
