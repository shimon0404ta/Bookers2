class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    #ユーザー登録(sign_up)の際に、ユーザー名(email)のデータ操作を許可 initializers/devise.rbではnameをユーザー登録の認証鍵にしてある
  end

end
