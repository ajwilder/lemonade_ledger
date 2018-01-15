class AddVendorPriceToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :vendor_price, :float
  end
end
