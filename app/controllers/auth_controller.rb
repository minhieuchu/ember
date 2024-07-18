class AuthController < ApplicationController
  skip_before_action :authenticate_request

  def login
    login_user = User.find_by_email(params[:email])
    if login_user&.authenticate(params[:password])
      access_token = create_access_token(login_user.email)
      refresh_token = create_refresh_token(login_user.email)
      render json: {
               access_token: access_token,
               refresh_token: refresh_token,
               token_type: "bearer",
             },
             status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def validate_access_token
    decoded_token = decode(params[:token])
    authenticate_user = User.find_by_email(decoded_token[:sub])

    if authenticate_user.nil? || decoded_token[:scope] != "access_token"
      render json: { error: "Invalid token" }
      return
    end

    expire_time = Time.at(decoded_token[:exp])
    if expire_time < Time.now
      render json: { error: "Token has expired" }
      return
    end

    render json: { valid: true }
  end

  private

  def create_access_token(email)
    encode(sub: email, scope: "access_token", exp: 1.day.from_now.to_i)
  end

  def create_refresh_token(email)
    encode(sub: email, scope: "refresh_token", exp: 7.days.from_now.to_i)
  end
end
