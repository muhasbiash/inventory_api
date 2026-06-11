class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.integer :stock
      t.decimal :price
      t.integer :min_stock
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
