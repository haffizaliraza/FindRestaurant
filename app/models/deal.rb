# frozen_string_literal: true

require 'csv'

class Deal < ApplicationRecord
  include Sluggish

  belongs_to :hotel

  before_create :set_slug

  validates :name, :hotel_name, :hotel_id, presence: true

  def self.import_from_csv(file)
    deals = []
    CSV.foreach(file.path, headers: true) do |row|
      deal = Deal.new
      deal.name = row['Name']
      deal.price = row['Price']
      deal.description = row['Description']
      deal.hotel_name = row['Restaurent Name']
      deal.hotel_id = Hotel.where("name LIKE ?", "%#{row['Restaurent Name'].strip}%")&.last&.id

      deals << deal if deal.save
    end
    deals
  end
end
