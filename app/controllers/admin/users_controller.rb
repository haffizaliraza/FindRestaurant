# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:edit, :update, :show, :destroy]

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'Users Created Successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: 'User is deleted sucessfully'
      else
        flash.now[:alert] = @user.errors.full_messages.to_sentence
      end
    end

    private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      user = params[:user] || params[:admin_user] || params[:customer]
      user.permit(:name, :email, :password, :password_confirmation, :type)
    end
  end
end
