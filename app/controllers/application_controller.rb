class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters  # メールアドレス以外の自分で追加したカラムを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
