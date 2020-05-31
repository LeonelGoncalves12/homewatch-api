# This controller allows the manipulation of the logged user's homes
class StatisticsController < ApplicationController
  before_action :authenticate_user

  def index
    statistics = current_user.statistics
    render json: statistics
  end

  def show
    statistic = current_user.statistics.find(params[:id])

    render json: statistic
  end

  def create
    if create_statistic_service.status
      render json: statistic, status: :created
    else
      render json: statistic.errors, status: :unprocessable_entity
    end
  end

  private

  def statistics_params
    params.require(:statistic).permit(:thingID)
  end
end
