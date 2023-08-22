class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers

  helper_method :current_user
  before_action :set_locale

  private def current_user
    @current_user ||= authenticate_by_session(User)
  end

  private def set_locale
    I18n.locale = current_user&.locale || request.headers["Accept-Language"].to_s.split("-").first || I18n.default_locale
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

  def set_cache_control_headers(max_age = 2592000)
    request.session_options[:skip] = true
    response.headers['Cache-Control'] = "public, no-cache"
    response.headers['Surrogate-Control'] = "max-age=#{max_age}"
  end
end
