class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    # @user ||= User.find(session[:user_id])
  end

  def login
  end

  def logged_in?
    !!session[:user_id]
  end

end
