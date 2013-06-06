class ApplicationController < ActionController::Base
  respond_to :html
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :user_activity

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email) }
  end

  private

  def user_activity
    current_user.try :touch
  end
end
