class ChangePriceTypeInSales < ActiveRecord::Migration[5.1]
  def change
    change_column :sales, :price, :float
  end
end
