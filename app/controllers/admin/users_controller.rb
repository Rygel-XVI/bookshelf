class Admin::UsersController < ApplicationController
  before_action :admin_required

  def index
    if current_user.admin
      @user = current_user
      @users = User.all
      @books = Book.all
      @author = Author.all
    else
      # flash msg need admin permissions
      redirect_to user_path(current_user)
    end
  end

  def edit
    @user = User.find(params[:id])
    @self = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params(params[:user]))
  end

  private

  def admin_required
   return head(:forbidden) unless current_user.admin
  end

end
