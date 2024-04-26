class AddDineInToHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :dine_in, :boolean
    add_column :hotels, :take_away, :boolean
  end
end
