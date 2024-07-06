module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from JWT::DecodeError, JWT::VerificationError do |_error|
      render json: {
               error: "Invalid token",
             }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |_error|
      render json: {
               error: "Record not found",
             }, status: :unprocessable_entity
    end
  end
end
