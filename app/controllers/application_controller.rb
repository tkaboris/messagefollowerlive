class ApplicationController < ActionController::Base

before_action :set_locale

def set_locale
  if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
    l = cookies[:educator_locale].to_sym
  else
    l = I18n.default_locale
    cookies.permanent[:educator_locale] = l
  end
  I18n.locale = l
end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def edit
    render 'speakers/registrations/edit'
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:organization, :address, :city, :state, :zipcode, :name, :lastname, :email, :password, :speaker_type, :speaker_bio) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :address, :city, :state, :zipcode, :lastname, :email, :password, :current_password, :avatar, :organization, :speaker_type, :speaker_bio, :attachments_attributes => [:file, :_destroy, :id]) }
  end
end
