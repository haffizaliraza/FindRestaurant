# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @location = user_loaction
    if @location
      @nearby_hotels = Hotel.where("address LIKE ?", "%#{@location}%")
      @hotels = Hotel.where.not("address LIKE ?", "%#{@location}%")
    else
      @nearby_hotels = []
      @hotels = Hotel.all
    end
  end
  
  def get_location
    @available_locations = []
    Location.all.each do |location|
      @available_locations << [location.name, location.name]
    end
  end

  def hotel
    @hotel = Hotel.includes(:deals, :products).find_by(slug: params[:id])
    return redirect_to root_path, alert: 'Something went wrong!' if @hotel.blank?

    @parent_comments = @hotel.comments_all_ordered
  end

  private 

  def user_loaction
    if params[:location]
      session[:location] = params[:location]
    end
    session[:location]
  end
end
