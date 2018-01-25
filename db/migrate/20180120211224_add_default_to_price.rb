class AddDefaultToPrice < ActiveRecord::Migration[5.1]
  def change
    change_column_default :sales, :price, 0.0
  end
end
