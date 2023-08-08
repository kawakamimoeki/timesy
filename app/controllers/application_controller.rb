class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers

  helper_method :current_user

  private def current_user
    @current_user ||= authenticate_by_session(User)
  end

  private def require_user!
    return if current_user
    redirect_to root_path, flash: { errors: I18n.t("users.not_signed_in") }
  end

  private def authenticate_user!
    token = request.headers["Authorization"]&.split&.last
    unless token
      render json: { errors: :unauthorized }, status: :unauthorized
      return
    end
    access_token = AccessToken.find_by(token: token)
    unless access_token
      render json: { errors: :unauthorized }, status: :unauthorized
      return
    end
    @current_user = access_token.user
  end
end
