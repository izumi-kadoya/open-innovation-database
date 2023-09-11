class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      redirect_to users_path, alert: 'There was an error updating the user.'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: 'User was successfully deleted.'
    else
      redirect_to users_path, alert: 'There was an error deleting the user.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:approved, :admin)
  end
end
