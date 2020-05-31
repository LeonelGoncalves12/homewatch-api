module ApplicationCable
  # This class is responsible for handling connections in websocket communication
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      logger.info('TEST_CONNECTION.RB')
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      token = Knock::AuthToken.new token: request.params[:token]

      verified_user = User.find_by id: token.payload["sub"]
      return verified_user if verified_user
      logger.info('TEST_rejected')
      reject_unauthorized_connection
    end
  end
end
