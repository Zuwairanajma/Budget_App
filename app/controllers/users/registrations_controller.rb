class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name])
  end
end
