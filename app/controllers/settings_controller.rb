class SettingsController < ApplicationController
  before_action :authenticate_user


  def index
    settings = current_user.settings
    render json: settings
  end

  def show
    setting = current_user.settings.find(params[:id])

    render json: setting
  end

  def create

    setting = current_user.settings.build(setting_params)

    if setting.save
      render json: setting, status: :created
    else
      render json: setting.errors, status: :unprocessable_entity
    end
  end

  def update
    setting = current_user.settings.find(params[:id])

    if setting.update(setting_params)
      render json: setting
    else
      render json: setting.errors, status: :unprocessable_entity
    end
  end

  def destroy
    setting = current_user.settings.find(params[:id])
    setting.destroy
  end

  private
  def setting_params    
    params.require(:setting).permit(:user_id, :timed_tasks_not, :triggered_tasks_not, :theme, :language)
  end
end
