# frozen_string_literal: true

module Admin
  class DealsController < BaseController
    before_action :set_deal, only: [:edit, :update, :show, :destroy]

    def index
      @deals = Deal.all
    end

    def new
      @deal = Deal.new
    end

    def show; end

    def edit; end

    def update
      if @deal.update(deal_params)
        redirect_to admin_deals_path, notice: 'Deal updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @deal = Deal.new(deal_params)
      if @deal.save
        redirect_to admin_deals_path, notice: 'Deals Created Successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @deal.destroy
        redirect_to admin_deals_path, notice: 'Deal is deleted sucessfully'
      else
        flash.now[:alert] = @deal.errors.full_messages.to_sentence
      end
    end

    def import_file
      file = params[:import_file]

      if file.content_type == 'text/csv'
        deal = Deal.import_from_csv(file)
        if deal.blank?
          redirect_to admin_deals_path, alert: 'File is not compatible!' 
        else
          redirect_to admin_deals_path, notice: 'File Imported Successfull!' 
        end
      else
        redirect_to admin_deals_path,
                    alert: 'Unsupported file type!'
      end
    end

    private

    def set_deal
      @deal = Deal.find_by(slug: params[:id])
    end

    def deal_params
      permit_params = params.require(:deal).permit(:name, :price, :hotel_id, :description)
      permit_params.merge!(hotel_name: Hotel.find_by(id: permit_params[:hotel_id]).name)

      permit_params
    end
  end
end
