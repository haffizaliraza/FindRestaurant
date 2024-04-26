class AddCommentCountToHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :comments_count, :integer
    add_column :hotels, :last_updated_at, :time
  end
end
