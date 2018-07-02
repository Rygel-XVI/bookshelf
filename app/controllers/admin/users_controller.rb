class Admin::UsersController < ApplicationController
  before_action :admin_required

  def index
    if current_user.admin
      @user = current_user
      @users = User.all
      @books = Book.all
      @author = Author.all
    else
      redirect_to user_path(current_user)
    end
  end

  def edit
    @user = User.find(params[:id])
    @self = current_user
  end

  def update
    @user = User.find(params[:id])
    if current_user.authenticate(params[:old_password]) && @user.update(user_params)
      flash[:msg] = "#{@user.name} Update Successful"
      redirect_to user_path(@user)
    else
      flash[:msg] = "#{@user.name} Not Updated"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
