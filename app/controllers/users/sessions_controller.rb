# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'unauthenticated'
  # before_action :configure_sign_in_params, only: [:create]

  # def new
  #   super
  # end

  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message(:notice, :signed_in) if is_navigational_format?
  #   sign_in(resource_name, resource)
  #   if !session[:return_to].blank?
  #     # redirect_to session[:return_to]
  #     session[:return_to] = nil
  #     redirect_to new_user_session_path, notice: 'kjfgkj'
  #   else
  #     respond_with resource, location: after_sign_in_path_for(resource)
  #   end
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
