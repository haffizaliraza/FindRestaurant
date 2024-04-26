class AddColumnToHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :close_at, :time
    add_column :hotels, :open_at, :time
  end
end
