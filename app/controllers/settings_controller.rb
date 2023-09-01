class SettingsController < ApplicationController
  before_action :require_user!

  def edit
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(profile_params)
      if profile_params[:avatar].present?
        @user.avatar.attach(profile_params[:avatar])
      end
      flash[:notice] = I18n.t('settings.updated')
    end
    purge_page(@user)
    redirect_to settings_path
  end

  def export
    @user = current_user
    ExportJob.perform_later(user_id: @user.id)
    flash[:notice] = I18n.t('settings.exporting')
    redirect_to settings_path
  end

  def update_theme
    @user = current_user
    if theme_params[:no_wallpaper] == "true"
      @user.wallpaper.purge
    end
    if theme_params[:wallpaper].present?
      @user.wallpaper.attach(theme_params[:wallpaper])
    end
    @user.update(
      locale: theme_params[:locale],
      code_theme_id: theme_params[:code_theme_id]
    )
    flash[:notice] = I18n.t('settings.updated')
    redirect_to settings_path
  end

  def update_access_token
    @user = current_user
    AccessToken.where(user_id: @user.id).destroy_all
    AccessToken.create(user_id: @user.id)
    flash[:notice] = I18n.t('settings.updated')
    redirect_to settings_path
  end

  def download_export
    export = current_user.exports.find(params[:id])
    if export.state == "completed"
      send_data export.download, filename: export.filename
    else
      flash[:notice] = I18n.t('settings.exporting')
      redirect_to settings_path
    end
  end

  def sidebar
    @user = current_user
  end

  private def purge_page(user)
    api_instance = Fastly::PurgeApi.new
    opts = {
        service_id: ENV['FASTLY_SERVICE_ID'],
        cached_url: "#{Site.origin}/#{user.username}",
        fastly_soft_purge: 1
    }
    begin
      result = api_instance.purge_single_url(opts)
    rescue Fastly::ApiError => e
      Rails.logger.error("Exception when calling PurgeApi->purge_single_url: #{e}")
    end
  end

  private def profile_params
    params.require(:user).permit(
      :email,
      :username,
      :name,
      :bio,
      :github,
      :twitter,
      :website,
      :avatar
    )
  end

  private def theme_params
    params.require(:user).permit(
      :locale,
      :wallpaper,
      :no_wallpaper,
      :code_theme_id
    )
  end
end
