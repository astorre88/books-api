# Create publishers
publisher1 = Publisher.create!(name: 'Doubleday')
publisher2 = Publisher.create!(name: 'Signet Books')

publisher_hash = {
  'Carrie' => publisher1,
  'The Shining' => publisher1,
  'Rage' => publisher2,
  'The Long Walk' => publisher2
}

# Create books
books = publisher_hash.map do |book_title, publisher|
  Book.create!(title: book_title, publisher: publisher)
end

shop_names = %w[Stanfords Gosh! Hatchards]

# Create shops
shops = shop_names.map do |shop_name|
  Shop.create!(name: shop_name)
end

# Buy books
3.times { shops[0].buy(books[0].id) }
2.times { shops[0].buy(books[1].id) }

# Sell books
shops[0].sell(books[0].id)

# Buy books
3.times { shops[1].buy(books[2].id) }
4.times { shops[1].buy(books[3].id) }

# Sell books
shops[1].sell(books[2].id)

# Buy books
2.times { shops[2].buy(books[0].id) }
2.times { shops[2].buy(books[1].id) }

# Sell books
2.times { shops[2].sell(books[1].id) }
