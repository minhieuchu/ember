class AuthController < ApplicationController
  skip_before_action :authenticate_request

  def login
    login_user = User.find_by_email(params[:email])
    if login_user&.authenticate(params[:password])
      token = encode(user_id: login_user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
