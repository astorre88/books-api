class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.belongs_to :book, null: false, index: true, foreign_key: { on_delete: :cascade }
      t.belongs_to :shop, null: false, index: true, foreign_key: { on_delete: :cascade }
      t.integer :copies_in_stock, null: false, default: 1
      t.integer :books_sold_count, null: false, default: 0

      t.timestamps
    end

    add_index :stocks, [:book_id, :shop_id], unique: true
  end
end
