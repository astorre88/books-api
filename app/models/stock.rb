class Stock < ApplicationRecord
  with_options required: true do |relation|
    relation.belongs_to :book
    relation.belongs_to :shop
  end

  validates_uniqueness_of :book, scope: [:shop]

  def increment_copies(copies_number = 1)
    increment! :copies_in_stock, copies_number
  end

  def decrement_copies(copies_number = 1)
    decrement! :copies_in_stock, copies_number
  end

  def increment_books_sold(copies_number = 1)
    increment! :books_sold_count, copies_number
  end

  def decrement_books_sold(copies_number = 1)
    decrement! :books_sold_count, copies_number
  end
end
