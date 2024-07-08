class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users/1
  def show
    render json: @user
  end

  # GET /connected_users
  def list_connected_users
    users_connections = UsersConnection.find_by_user @current_user.id
    user_ids = users_connections.map do |connection|
      if connection.user_a_id == @current_user.id
        connection.user_b_id
      else
        connection.user_a_id
      end
    end

    connected_users = User.where id: user_ids
    render json: connected_users
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
