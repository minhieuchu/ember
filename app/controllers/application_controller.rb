class ApplicationController < ActionController::API
  include JsonWebToken, ExceptionHandler

  before_action :authenticate_request

  private

  def authenticate_request
    authorization_header = request.headers["Authorization"]
    token = authorization_header.split(" ").last if authorization_header
    decoded_token = decode(token)
    @current_user = User.find(decoded_token[:user_id]) if decoded_token.key?(:user_id)
    if @current_user.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
