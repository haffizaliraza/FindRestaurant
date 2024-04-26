# frozen_string_literal: true

module Admin
  class HotelsController < BaseController
    before_action :set_hotel, only: [:edit, :update, :show, :destroy]

    def index
      @hotels = Hotel.all
    end

    def new
      @hotel = Hotel.new
    end

    def show; end

    def edit; end

    def update
      if @hotel.update(hotel_params.except(:images))
        @hotel.images.attach(hotel_params[:images])
        redirect_to admin_hotels_path, notice: 'Hotel updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @hotel = Hotel.new(hotel_params)
      if @hotel.save
        redirect_to admin_hotels_path, notice: 'Hotels Created Successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @hotel.destroy
        redirect_to admin_hotels_path, notice: 'Hotel is deleted sucessfully'
      else
        flash.now[:alert] = @hotel.errors.full_messages.to_sentence
      end
    end

    def import_file
      file = params[:import_file]

      if file.content_type == 'text/csv'
        hotel = Hotel.import_from_csv(file)
        if hotel.blank?
          redirect_to admin_hotels_path, alert: 'File is not compatible!' 
        else
          redirect_to admin_hotels_path, notice: 'File Imported Successfull!' 
        end
      else
        redirect_to admin_hotels_path,
                    alert: 'Unsupported file type!'
      end
    end

    private

    def set_hotel
      @hotel = Hotel.find_by(slug: params[:id])
    end

    def hotel_params
      params.require(:hotel).permit(
        :name, :address, :latitude, :longitude, :phone, :close_at, :open_at, images: []
      )
    end
  end
end
