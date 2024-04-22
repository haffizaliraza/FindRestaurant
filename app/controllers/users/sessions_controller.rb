# frozen_string_literal: true

module Users
  #
  # Sessions
  #
  class SessionsController < Devise::SessionsController
    # POST /resource/sign_in
    def create
      super
    end

    private

    def after_sign_in_path_for(resource)
      dashboard_path
    end
  end
end
