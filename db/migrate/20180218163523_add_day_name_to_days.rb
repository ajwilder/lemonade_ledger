class AddDayNameToDays < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :date, :string
    add_index :days, [:location, :date], unique: true
  end
end
