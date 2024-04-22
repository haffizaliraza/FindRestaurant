class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price
      t.text :description
      t.string :hotel_name, null: false
      t.string :slug

      t.timestamps
    end
  end
end
