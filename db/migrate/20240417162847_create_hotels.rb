class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :latitude
      t.string :longitude
      t.string :phone
      t.string :slug


      t.timestamps
    end
  end
end
