class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:organization, :name, :lastname, :email, :password, :speaker_type, :speaker_bio) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :lastname, :email, :password, :current_password, :avatar, :organization, :speaker_type, :speaker_bio) }
  end
end
