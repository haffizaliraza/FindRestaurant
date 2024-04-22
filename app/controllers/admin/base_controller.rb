# frozen_string_literal: true

module Admin
  # Base controller for all admin controllers
  #
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin!

    layout 'admin'

    private

    def check_admin!
      unless current_user.admin_user?
        redirect_to root_path, alert: 'Not Authorized!'
      end
    end
  end
end
