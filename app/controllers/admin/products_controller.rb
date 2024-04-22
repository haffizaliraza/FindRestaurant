# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
    before_action :set_product, only: [:edit, :update, :show, :destroy]

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def show; end

    def edit; end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: 'Product updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: 'Products Created Successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @product.destroy
        redirect_to admin_products_path, notice: 'Product is deleted sucessfully'
      else
        flash.now[:alert] = @product.errors.full_messages.to_sentence
      end
    end

    def import_file
      file = params[:import_file]

      if file.content_type == 'text/csv'
        product = Product.import_from_csv(file)
        if product.blank?
          redirect_to admin_products_path, alert: 'File is not compatible!' 
        else
          redirect_to admin_products_path, notice: 'File Imported Successfull!' 
        end
      else
        redirect_to admin_products_path,
                    alert: 'Unsupported file type!'
      end
    end

    private

    def set_product
      @product = Product.find_by(slug: params[:id])
    end

    def product_params
      permit_params = params.require(:product).permit(:name, :price, :hotel_id, :description)
      permit_params.merge!(hotel_name: Hotel.find_by(id: permit_params[:hotel_id]).name)

      permit_params
    end
  end
end
