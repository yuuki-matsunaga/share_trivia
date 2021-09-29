class ApplicationController < ActionController::Base

  #deviseのcontoller修正
  #カラム[name]の追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def configure_permitted_parameters  # メールアドレス以外の自分で追加したカラムを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
