class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :drink_type
      t.string :cup_type
      t.float :price
    end
  end
end
