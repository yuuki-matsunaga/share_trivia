# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  def twitter
    authorization   # コールバック
  end

  def facebook
    authorization   # コールバック
  end

  def google_oauth2
    authorization   # コールバック
  end

  def failure
    redirect_to root_path
  end

  private
  # コールバックのメソッド定義
  def authorization   # APIから取得したユーザー情報はrequest.env["omniauth.auth"]に格納されてる
    sns_info = User.from_omniauth(request.env["omniauth.auth"])     # User.from_omniauth は、モデルで定義（次項）
    @user = sns_info[:user]    # deviseのヘルパーを使うため、＠user に代入(ハッシュ(モデルの返り値)から値を取得)

    if @user.persisted? # ユーザー登録済み(ログイン処理)
      sign_in_and_redirect @user, event: :authentication   # authenticationのcallbackメソッドを呼んで、@user でログイン
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else                # ユーザー未登録(新規登録画面へ遷移)
      @sns_id = sns_info[:sns].id                  # ハッシュ(モデルの返り値)から取得した、認証データを一時的に保持(ユーザー登録ページに渡す)
      render template: new_user_registration_url   # ユーザー登録ページに遷移
    end
  end


  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

end
