# frozen_string_literal: true

module Admin
  class LocationsController < BaseController
    before_action :set_location, only: [:edit, :update, :show, :destroy]

    def index
      @locations = Location.all
    end

    def new
      @location = Location.new
    end

    def show; end

    def edit; end

    def update
      if @location.update(location_params)
        redirect_to admin_locations_path, notice: 'Location updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @location = Location.new(location_params)
      if @location.save
        redirect_to admin_locations_path, notice: 'Locations Created Successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @location.destroy
        redirect_to admin_locations_path, notice: 'Location is deleted sucessfully'
      else
        flash.now[:alert] = @location.errors.full_messages.to_sentence
      end
    end

    private

    def set_location
      @location = Location.find_by(slug: params[:id])
    end

    def location_params
      params.require(:location).permit(:name)
    end
  end
end
