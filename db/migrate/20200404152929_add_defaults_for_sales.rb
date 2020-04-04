class AddDefaultsForSales < ActiveRecord::Migration[5.1]
  def change
    change_column_default :sales, :donut, 0
    change_column_default :sales, :reusable_straw, 0
    change_column_default :sales, :reusable_straw_bag, 0
  end
end
