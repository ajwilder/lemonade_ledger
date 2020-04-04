class AddEmergencyRestocks < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :reusable_straw_emergency_restock, :integer, default: 0
    add_column :days, :reusable_straw_bag_emergency_restock, :integer, default: 0
    add_column :days, :donut_emergency_restock, :integer, default: 0
  end
end
