class DirectMessagesController < ApplicationController
  before_action :set_message, only: %i[ update destroy ]

  # GET /chat
  def chat
    @messages = DirectMessage.chat_between(@current_user.id, params[:user_id])
    render json: @messages
  end

  # POST /messages
  def create
    sender_id = message_params[:sender_id]
    recipient_id = message_params[:recipient_id]
    redis_connection_key = "users_connection:#{[sender_id, recipient_id].sort.join(":")}"
    redis_connection_value = $redis.get(redis_connection_key)

    unless redis_connection_value
      existing_connection = (UsersConnection.find_by user_a_id: sender_id, user_b_id: recipient_id) ||
                            (UsersConnection.find_by user_a_id: recipient_id, user_b_id: sender_id)

      if existing_connection.nil?
        new_connection = UsersConnection.create user_a_id: sender_id, user_b_id: recipient_id
      end

      if existing_connection || new_connection.persisted?
        $redis.set(redis_connection_key, 1)
      end
    end

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
