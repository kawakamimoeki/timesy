class SettingsController < ApplicationController
  before_action :require_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(setting_params)
      if setting_params[:avatar].present?
        @user.avatar.attach(setting_params[:avatar])
      end
      flash[:notice] = I18n.t('settings.updated')
    end
    render :edit
  end

  def export
    @user = current_user
    ExportJob.perform_later(user_id: @user.id)
    flash[:notice] = I18n.t('settings.exporting')
    redirect_to settings_path
  end

  private def setting_params
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
end
