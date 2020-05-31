class RoomsController < ApplicationController
  before_action :authenticate_user

  def index
    home = current_user.homes.find(params[:home_id])
    rooms = home.rooms

    render json: rooms
  end

  def show
    room = current_user.rooms.find(params[:id])

    render json: room
  end

  def create

    home = current_user.homes.find(params[:home_id])
    room = home.rooms.build(room_params)

    if room.save
      render json: room, status: :created
    else
      render json: room.errors, status: :unprocessable_entity
    end
  end

  def update
    room = current_user.rooms.find(params[:id])
    if room.update(room_params)
      render json: room
    else
      render json: room.errors, status: :unprocessable_entity
    end
  end


  def destroy
    room = current_user.rooms.find(params[:id])

    room.destroy
  end

  private

  def room_params
    params.require(:room).permit(:name, :owner, :icon)
  end

end
