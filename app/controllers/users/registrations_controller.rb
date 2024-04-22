# frozen_string_literal: true

module Users
  #
  # Registrations
  #
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    def create
      debugger
      build_resource(sign_up_params)

      if resource.save
        yield resource if block_given?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :name, :type, :password, :password_confirmation)}
    end
  end
end
