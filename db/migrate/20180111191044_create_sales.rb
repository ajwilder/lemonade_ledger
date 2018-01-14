class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.text :items, array: true, default: []

      t.integer :price

      t.integer :large
      t.integer :small
      t.integer :bottle
      t.integer :hot_medium
      t.integer :hot_small

      t.boolean :discount, default: false

      t.references :day, foreign_key: true

      t.timestamps
    end
  end
end
