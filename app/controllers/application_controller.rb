class ApplicationController < ActionController::Base

  #deviseのcontoller修正
  #カラム[name]の追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  helper_method :logged_in?

  private

  def logged_in?
    session[:user_id].present?
  end

end
