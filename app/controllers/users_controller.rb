class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to users_path
    else
      flash.now[:alert] = 'There was an error updating the user.'
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'User was successfully deleted.'
      redirect_to users_path
    else
      flash.now[:alert] = 'There was an error deleting the user.'
      render :index
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
