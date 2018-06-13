class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def current_user
  #   binding.pry
  #   session[:user_id]
  # end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    # redirect_to login_path unless !!current_user
    !!current_user
  end

end
