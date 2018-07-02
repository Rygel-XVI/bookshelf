class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    redirect_to root_path unless !!current_user
  end

  def is_admin?
    logged_in? && current_user.admin
  end

  def admin_required
   return head(:forbidden) unless current_user.admin
  end

  def set_user
    @user = current_user
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def set_author
    @author = Author.find(params[:id])
  end

end
