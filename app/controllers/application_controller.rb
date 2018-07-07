class ApplicationController < ActionController::Base
  include ButtonMaker

  protect_from_forgery with: :exception

  # returns currently logged in user
  def current_user
    User.find(session[:user_id])
  end

  # logs user in
  def login(user)
    session[:user_id] = user.id
  end

  # checks if someone is logged in
  def logged_in?
    !!session[:user_id]
  end

  # checks if currently logged in user is admin
  def is_admin?
    logged_in? && current_user.admin
  end



######## Before_action methods ########

  # redirects to root view unless logged in

  # add if current_user and !!logged_in? session.clear
  def redirect_unless_logged_in
    redirect_to root_path unless logged_in? && !!current_user
  end

  # redirects away unless current user is admin
  def admin_required
   return head(:forbidden) unless current_user.admin
  end



#########  These methods set variables  #########

  # sets @user to logged in user
  def set_user
    @user = current_user
  end

  # sets @book
  def set_book
    @book = Book.find(params[:id])
  end

  # sets author
  def set_author
    @author = Author.find(params[:id])
  end

end
