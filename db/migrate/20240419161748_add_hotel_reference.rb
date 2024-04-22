class AddHotelReference < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :hotel, index: true
    add_reference :deals, :hotel, index: true
  end
end
