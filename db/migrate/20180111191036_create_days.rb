class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|

      t.text :employees, array: true, default: []
      t.string :location

      t.boolean :closed, :default => false

      t.float :cash_start
      t.float :cash_end

      t.integer :large_start
      t.integer :large_restock
      t.integer :large_end
      t.integer :large_discrepancy

      t.integer :small_start
      t.integer :small_restock
      t.integer :small_end
      t.integer :small_discrepancy

      t.integer :bottle_start
      t.integer :bottle_restock
      t.integer :bottle_end
      t.integer :bottle_discrepancy

      t.integer :hot_medium_start
      t.integer :hot_medium_restock
      t.integer :hot_medium_end
      t.integer :hot_medium_discrepancy

      t.integer :hot_small_start
      t.integer :hot_small_restock
      t.integer :hot_small_end
      t.integer :hot_small_discrepancy

      t.timestamps

    end
  end
end
