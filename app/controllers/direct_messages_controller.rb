class DirectMessagesController < ApplicationController
  before_action :set_message, only: %i[ update destroy ]

  # GET /chat
  def chat
    @messages = DirectMessage.chat_between(@current_user.id, params[:user_id])
    render json: @messages
  end

  # POST /messages
  def create
    @message = DirectMessage.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = DirectMessage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:direct_message).permit(:sender_id, :recipient_id, :content)
  end
end
