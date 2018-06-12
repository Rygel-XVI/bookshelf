class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    session[:user_id]
  end

  def login
  end

  def logged_in?
  redirect_to login_path unless !!current_user
end

end
