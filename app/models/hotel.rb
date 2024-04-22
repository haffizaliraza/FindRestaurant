# frozen_string_literal: true

require 'csv'

class Hotel < ApplicationRecord
  include Sluggish

  has_many :deals
  has_many :products

  before_create :set_slug

  validates :name, :latitude, :longitude, presence: true

  def self.import_from_csv(file)
    hotels = []
    CSV.foreach(file.path, headers: true) do |row|
      hotel = Hotel.new
      hotel.name = row['Name']
      hotel.address = row['Address']
      hotel.latitude = row['Latitude']
      hotel.longitude = row['Longitude']
      hotel.phone = row['Phone']

      hotels << hotel if hotel.save
    end
    hotels
  end
end
