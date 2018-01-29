class AddDefaultToEmergencyRestock < ActiveRecord::Migration[5.1]
  def change
    change_column_default :days, :small_emergency_restock, 0
    change_column_default :days, :large_emergency_restock, 0
    change_column_default :days, :hot_small_emergency_restock, 0
    change_column_default :days, :hot_medium_emergency_restock, 0
    change_column_default :days, :bottle_emergency_restock, 0

  end
end
