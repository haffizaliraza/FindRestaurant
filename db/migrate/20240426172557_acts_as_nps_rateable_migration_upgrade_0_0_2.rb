# @private
class ActsAsNpsRateableMigrationUpgrade002 < ActiveRecord::Migration[7.0]
  def change
    add_column :nps_ratings, :comments, :text
  end
end
