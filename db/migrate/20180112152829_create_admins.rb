class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.text :employees, array: true, default: []
      t.text :locations, array: true, default: []

      t.timestamps
    end
  end
end
