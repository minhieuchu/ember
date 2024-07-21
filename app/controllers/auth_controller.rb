class AuthController < ApplicationController
  skip_before_action :authenticate_request

  def login
    login_user = User.find_by_email(params[:email])
    if login_user&.authenticate(params[:password])
      access_token = create_access_token(login_user.email)
      refresh_token = create_refresh_token(login_user.email)
      cookies[:access_token] = {
        value: access_token,
        httponly: true,
        samesite: :strict,
        expires: 1.day.from_now,
      }
      cookies[:refresh_token] = {
        value: refresh_token,
        httponly: true,
        samesite: :strict,
        expires: 1.week.from_now,
      }
      render json: { message: "Login successfully" }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def validate_access_token
    decoded_token = decode(cookies[:access_token])
    authenticate_user = User.find_by_email(decoded_token[:sub])

    if authenticate_user.nil? || decoded_token[:scope] != "access_token"
      render json: { error: "Invalid token" }
      return
    end

    render json: { valid: true }
  end

  private

  def create_access_token(email)
    encode(sub: email, scope: "access_token")
  end

  def create_refresh_token(email)
    encode(sub: email, scope: "refresh_token")
  end
end
