class AddChecklistAndInventoryToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :farmers_am, :text, array: true, default: []
    add_column :admins, :farmers_pm, :text, array: true, default: []
    add_column :admins, :city_am, :text, array: true, default: []
    add_column :admins, :city_pm, :text, array: true, default: []
    add_column :admins, :small_invent, :integer
    add_column :admins, :large_invent, :integer
    add_column :admins, :hot_small_invent, :integer
    add_column :admins, :hot_medium_invent, :integer
    add_column :admins, :bottles_invent, :integer
  end
end
