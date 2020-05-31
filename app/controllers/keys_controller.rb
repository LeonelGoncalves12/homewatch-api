class KeysController < ApplicationController
  require 'openssl'
  require "base64"
  require 'base64'

  def show
    id = ENV[params[:id]]
    encoded = Base64.encode64(id)
    p encoded
    render json: encoded
  end

  private

  def key_params
    params.require(:key).permit(:name, :info)
  end
end
