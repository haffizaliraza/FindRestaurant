# frozen_string_literal: true

require 'csv'

class Hotel < ApplicationRecord
  include Sluggish

  has_many :deals
  has_many :products
  has_many_attached :images
  has_many :comments, as: :commentable, dependent: :destroy

  before_create :set_slug

  validates :name, :phone, :close_at, :open_at, presence: true

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

  def self.comments_count
    sum(:comments_count)
  end

  def parent_comments
    comments.where(parent_id: nil).load_associations
  end

  def touch_last_updated_at
    update_column(:last_updated_at, Time.zone.now)
  end

  def comments_all_ordered
    parent_comments.includes(:replies).order(last_updated_at: :desc)
  end
end
