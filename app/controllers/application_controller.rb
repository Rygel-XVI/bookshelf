class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    # redirect_to login_path unless !!current_user
    redirect_to root_path unless !!current_user
  end

  def is_admin?
    logged_in? && current_user.admin
  end

  private

  def user_params(args)
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_required
   return head(:forbidden) unless current_user.admin
  end

end
