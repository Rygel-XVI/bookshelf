class Admin::UsersController < ApplicationController
  before_action :redirect_unless_logged_in, :admin_required

  def index
    set_user
    @users = User.all
    @books = Book.all
    @author = Author.all
  end

  def edit
    set_target_user
    set_user
  end

  def update
    set_target_user
    set_user
    # Hash::check("param1", "param2")
    if valid_pass? && user_updated?
      flash[:msg] = "#{@target_user.name} Update Successful"
      redirect_to edit_admin_user_path(@target_user)
    else
      flash[:msg] = "#{@target_user.name} Not Updated"
      render 'edit'
    end
  end

  def destroy
    set_target_user
    if @target_user.destroy
      @target_user.user_books.destroy_all
      flash[:msg] = "#{@target_user.name} Destroyed"
      redirect_to admin_users_path
    else
      flash[:msg] = "User not deleted please notify admin"
      redirect_to admin_user_path(@target_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def default_pass?
    @user.password_digest == "newuser"
  end

  def valid_pass?
    default_pass? || @user.authenticate(params[:old_password])
  end

  def user_updated?
    @target_user.update(user_params)
  end

  def set_target_user
    @target_user = User.find(params[:id])
  end

end
