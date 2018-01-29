class AddEmergencyRestockToDays < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :large_emergency_restock, :integer
    add_column :days, :small_emergency_restock, :integer
    add_column :days, :hot_small_emergency_restock, :integer
    add_column :days, :hot_medium_emergency_restock, :integer
    add_column :days, :bottle_emergency_restock, :integer

  end
end
