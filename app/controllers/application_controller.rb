class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ログアウト、退会後の遷移先
  def after_sign_out_path_for(resource)
      root_path
  end

  def configure_permitted_parameters
    # エンドユーザー側の新規登録情報時に下記項目の操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    # 管理者側とエンドユーザー側のログイン時に下記項目の操作を許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
