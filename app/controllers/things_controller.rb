# This controller allows the manipulation of the logged user's things
class ThingsController < ApplicationController
  before_action :authenticate_user

  def index
    room = current_user.rooms.find(params[:room_id])
    things = room.things

    render json: things
  end

  def show
    thing = current_user.things.find(params[:id])

    render json: thing
  end

  def create
    room = current_user.rooms.find(params[:room_id])

    thing = room.things.build(thing_params)

    begin
      if thing.save
        @params = ActionController::Parameters.new({statistic: {
            thingID: thing.id,

        }})
        create_statistic_service = CreateStatistic.new(user: current_user, params: statistic_params)

        statistic = create_statistic_service.perform
        statistic.save

        render json: thing, status: :created
      else
        render json: thing.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    thing = current_user.things.find(params[:id])

    if thing.update(thing_params)
      render json: thing
    else
      render json: thing.errors, status: :unprocessable_entity
    end
  end

  def destroy
    thing = current_user.things.find(params[:id])

    thing.destroy
  end

  private

  def thing_params
    thing_params = params.require(:thing).permit(:name, :favorite, :subtype, :type)
    thing_params[:connection_info] = params[:thing][:connection_info]
    thing_params.permit!
  end


  def statistic_params
    statistic_params = @params.require(:statistic).permit(:thingID)
   # statistic_params[:status] = @params[:statistic][:status].transform_keys(&:to_sym).permit!

    statistic_params.permit!
  end

end
