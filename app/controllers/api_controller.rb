class ApiController < ActionController::API
  before_action :authenticate_token!

  private

    def authenticate_token!
      payload = JsonWebToken.decode(auth_token)
      @current_user = User.find(payload['id'])
      rescue JWT::ExpiredSignature
        render json: { errors: ['Auth Token has Expired'] }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { errors: ['Invalid Auth Token'] }, status: :unauthorized
    end

    def auth_token
      @auth_token ||= request.headers.fetch("Authorization", "").split(' ').last
    end
end
