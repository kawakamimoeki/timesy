class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers

  protect_from_forgery prepend: true

  helper_method :current_user

  private def current_user
    @current_user ||= authenticate_by_session(User)
  end

  private def require_user!
    return if current_user
    redirect_to root_path, flash: { errors: I18n.t("users.not_signed_in") }
  end
end
