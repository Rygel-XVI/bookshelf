class UsersController < ApplicationController

  def index

  end

  def show
    # @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    if User.find_by(name: params[:user][:name])
      ##flash error message user already exists
      redirect_to new_user_path
    else
      @user = User.create(user_params(params[:user]))
      redirect_to user_path(@user)
    end
  end

  def destroy

  end

  private

  def user_params(args)
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
