class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[ show update destroy ]

  # GET /channels
  def index
    @channels = Channel.find_by_user_id(@current_user.id)
    render json: @channels
  end

  # GET /channels/1
  def show
    if @channel.users.any? { |user| user.id == @current_user.id }
      render json: @channel
    end
  end

  # POST /channels
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      render json: @channel, status: :created, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /channels/1
  def update
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:name)
  end
end
