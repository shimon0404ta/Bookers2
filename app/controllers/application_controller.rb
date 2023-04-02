class ApplicationController < ActionController::Base
  # 全てのアクションの前に、ユーザーがログインしているかどうか確認する！
  before_action :authenticate_user!, except: [:top, :about]
  # device利用の機能が使用される場合、:configure_permitted~が実行される
  before_action :configure_permitted_parameters,if: :devise_controller?

  # ログイン後マイページに移行
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  # ログアウト後トップページに移行
  def after_sign_out_path_for(resource)
    root_path
  end
  # 他のコントローラからも参照できる
  protected
  # sign_upの際にnameとemailが認証キー
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:name,:email])
  end

end