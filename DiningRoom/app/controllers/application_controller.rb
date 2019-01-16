class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  include ApplicationHelper
  before_action :set_model
  before_action :authenticate_user!



  def configure_permitted_parametersod_name
    devise_parameter_sanitizer.permit(:sign_in) {|u| u.permit(:nr)}
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:nr, :password, password_confirmation)}
  end


  layout :layout_by_resource

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  def layout_by_resource
    if devise_controller?
      "no_authorization"
    else
      "application"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_no
  end



  private
  def authenticate_user_from_token!
    # Need to pass email and token every request
    user_nr = params[:nr].presence
    user = user_nr && User.find_by_nr(user_nr)

    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end


  def set_model
    @model=self.class.name.gsub(/Controller/, '').tableize.singularize
  end

  def model
    self.class.name.gsub(/Controller/, '').classify.constantize
  end



end
