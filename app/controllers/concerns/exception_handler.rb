module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from JWT::DecodeError, JWT::VerificationError do |_error|
      render json: {
               error: "Invalid token",
             }, status: :unauthorized
    end
  end
end
