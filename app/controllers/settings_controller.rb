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
    redirect_to settings_path
  end

  def export
    @user = current_user
    ExportJob.perform_later(user_id: @user.id)
    flash[:notice] = I18n.t('settings.exporting')
    redirect_to settings_path
  end

  def update_webhook
    @user = current_user
    if @user.update(webhook_params)
      flash[:notice] = I18n.t('settings.updated')
    end
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

  private def webhook_params
    params.require(:user).permit(
      :webhook_url
    )
  end
end
