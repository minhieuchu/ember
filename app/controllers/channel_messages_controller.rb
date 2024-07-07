class ChannelMessagesController < ApplicationController
  before_action :set_channel_message, only: %i[ update destroy ]

  # GET /channels/:channel_id
  def list
    @channel = Channel.find(params[:channel_id])
    if !@channel.user_ids.include? @current_user.id
      render json: { error: "User is not a member of channel" }, status: :unprocessable_entity
    else
      @message_list = ChannelMessage.find_by_channel(params[:channel_id])
      render json: @message_list
    end
  end

  # POST /channel_messages
  def create
    @channel = Channel.find(channel_message_params[:channel_id])
    if !@channel.user_ids.include? channel_message_params[:user_id]
      render json: { error: "User is not a member of channel" }, status: :unprocessable_entity
    end
    @channel_message = ChannelMessage.new(channel_message_params)

    if @channel_message.save
      render json: @channel_message, status: :created, location: @channel_message
    else
      render json: @channel_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channel_messages/1
  def update
    if @channel_message.update(channel_message_params)
      render json: @channel_message
    else
      render json: @channel_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channel_messages/1
  def destroy
    @channel_message.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel_message
    @channel_message = ChannelMessage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def channel_message_params
    params.require(:channel_message).permit(:user_id, :channel_id, :content)
  end
end
