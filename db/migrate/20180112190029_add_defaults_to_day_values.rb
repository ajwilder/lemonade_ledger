class AddDefaultsToDayValues < ActiveRecord::Migration[5.1]
  def change
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_end, 0
    change_column_default :days, :large_restock, 0
    change_column_default :days, :large_discrepancy, 0
    change_column_default :days, :small_start, 0
    change_column_default :days, :small_end, 0
    change_column_default :days, :small_restock, 0
    change_column_default :days, :small_discrepancy, 0
    change_column_default :days, :bottle_start, 0
    change_column_default :days, :bottle_end, 0
    change_column_default :days, :bottle_restock, 0
    change_column_default :days, :bottle_discrepancy, 0
    change_column_default :days, :hot_small_start, 0
    change_column_default :days, :hot_small_end, 0
    change_column_default :days, :hot_small_restock, 0
    change_column_default :days, :hot_small_discrepancy, 0
    change_column_default :days, :hot_medium_start, 0
    change_column_default :days, :hot_medium_end, 0
    change_column_default :days, :hot_medium_restock, 0
    change_column_default :days, :hot_medium_discrepancy, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
    change_column_default :days, :large_start, 0
  end
end
