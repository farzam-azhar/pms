class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:user][:email])
    if user
      if user.valid_password? params[:user][:password]
        render json: { token: JsonWebToken.encode(id: user.id) }
      else
        render json: { errors: ["Invalid Password"] }
      end
    else
      render json: { errors: ["Invalid Email"] }
    end
  end
end
