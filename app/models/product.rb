# frozen_string_literal: true

require 'csv'

class Product < ApplicationRecord
  include Sluggish

  belongs_to :hotel

  before_create :set_slug

  validates :name, :hotel_name, presence: true

  def self.import_from_csv(file)
    products = []
    CSV.foreach(file.path, headers: true) do |row|
      product = Product.new
      product.name = row['Name']
      product.price = row['Price']
      product.description = row['Description']
      product.hotel_name = row['Restaurent Name']
      product.hotel_id = Hotel.find_by(name: row['Restaurent Name'].strip)&.id

      products << product if product.save
    end
    products
  end
end
