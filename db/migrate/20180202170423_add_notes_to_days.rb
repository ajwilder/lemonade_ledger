class AddNotesToDays < ActiveRecord::Migration[5.1]
  def change
    add_column :days, :notes, :text, array: true, default: []
  end
end
