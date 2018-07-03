class Admin::UsersController < ApplicationController
  before_action :admin_required

  def index
    set_user
    @users = User.all
    @books = Book.all
    @author = Author.all
  end

  def edit
    @target_user = User.find(params[:id])
    set_user
    @submit_msg = "Admin Password"
  end

  def update
    @target_user = User.find(params[:id])
    if current_user.authenticate(params[:old_password]) && @target_user.update(user_params)
      flash[:msg] = "#{@target_user.name} Update Successful"
      redirect_to edit_admin_user_path(@target_user)
    else
      flash[:msg] = "#{@target_user.name} Not Updated"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
