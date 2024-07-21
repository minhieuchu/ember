class ApplicationController < ActionController::API
  include ActionController::Cookies
  include JsonWebToken, ExceptionHandler

  before_action :authenticate_request

  private

  def authenticate_request
    token = cookies[:access_token]
    if token.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    decoded_token = decode(token)
    @current_user = User.find_by_email(decoded_token[:sub]) if decoded_token.key?(:sub)
    if @current_user.nil?
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end
