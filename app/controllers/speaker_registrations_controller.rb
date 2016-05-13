class SpeakerRegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

   # GET /resource/edit
  def edit
    render 'speakers/registrations/edit'
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :lastname, :email, :password, :time_zone, :recieve_message_at, :locale, :speaker_ids => []) }
    # devise_parameter_sanitizer.for(:account_update).push(:speaker_ids => [])
    # devise_parameter_sanitizer.for(:account_update).push(:speaker_ids => []) { |u| u.permit(:name, :lastname, :email, :password, :current_password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :lastname, :email, :password,
     :current_password, :time_zone, :recieve_message_at, :avatar, :locale, :speaker_ids => [], :attachments_attributes => [:file, :_destroy, :id])}
  end
end
