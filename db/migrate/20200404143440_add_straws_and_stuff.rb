class AddStrawsAndStuff < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :reusable_straw_start, :integer, default: 0
    add_column :days, :reusable_straw_end, :integer, default: 0
    add_column :days, :reusable_straw_discrepancy, :integer, default: 0
    add_column :days, :reusable_straw_restock, :integer, default: 0
    add_column :days, :reusable_straw_bag_start, :integer, default: 0
    add_column :days, :reusable_straw_bag_end, :integer, default: 0
    add_column :days, :reusable_straw_bag_discrepancy, :integer, default: 0
    add_column :days, :reusable_straw_bag_restock, :integer, default: 0
    add_column :days, :donut_start, :integer, default: 0
    add_column :days, :donut_end, :integer, default: 0
    add_column :days, :donut_discrepancy, :integer, default: 0
    add_column :days, :donut_restock, :integer, default: 0
    add_column :sales, :donut, :integer
    add_column :sales, :reusable_straw, :integer
    add_column :sales, :reusable_straw_bag, :integer
    add_column :admins, :donut_invent, :integer
    add_column :admins, :reusable_straw_invent, :integer
    add_column :admins, :reusable_straw_bag_invent, :integer
  end
end
