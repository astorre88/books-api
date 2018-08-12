class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.belongs_to :publisher, null: false, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
