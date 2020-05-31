# This controller allows an authenticated user to apply a given scenario
class ScenarioAppliesController < ApplicationController
  before_action :authenticate_user

  def create
    scenario = current_user.scenarios.find(params[:scenario_id])
    scenario.delay.apply

    @params = ActionController::Parameters.new({statistic: {
        scenario: params[:scenario_id]
      }})
    create_statistic_service = CreateStatistic.new(user: current_user, params: statistic_params)

    statistic = create_statistic_service.performStat
    statistic.save

    head :ok
  end

  def statistic_params

    statistic_params = @params.require(:statistic).permit(:scenario)

    statistic_params.permit!
  end
end
