class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :books_sold_count

  has_many :books_in_stock

  def books_sold_count
    Stock.joins(:book)
         .where("books.publisher_id = #{@instance_options[:publisher_id]} and shop_id = #{object.id}")
         .sum(:books_sold_count)
  end

  def books_in_stock
    customized_books = []

    object.books.where(publisher_id: @instance_options[:publisher_id]).each do |book|
      custom_book = {
        id: book.id,
        title: book.title,
        copies_in_stock: Stock.joins(:book)
                              .where("books.id = #{book.id} and shop_id = #{object.id}")
                              .sum(:copies_in_stock)
      }

      customized_books.push(custom_book)
    end

    customized_books
  end
end
