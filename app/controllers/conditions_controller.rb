# This controller allows the manipulation of the logged user WEATHER
class ConditionsController < ApplicationController
  before_action :authenticate_user

  def index
    conditions = current_user.conditions
    render json: conditions
  end

  def show
    condition = current_user.conditions.find(params[:id])

    render json: condition
  end

  def create
    condition = current_user.conditions.build(condition_params)
  
    if condition.save
 
      render json: condition, status: :created
    else
      render json: condition.errors, status: :unprocessable_entity
    end
  end

  def update
    condition = current_user.conditions.find(params[:id])
    if condition.update(condition_params)

      render json: condition
    else

      render json: condition.errors, status: :unprocessable_entity
    end
  end

  def destroy
    condition = current_user.conditions.find(params[:id])

    condition.destroy
  end

  private

  def condition_params
    params.require(:condition).permit(:city, :wind, :humidity, :sunrise, :sunset, :icon, :temperature, :description)

  end
end