class SessionsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
      render '/sessions/login'
    end
  end

  def fail
    raise params.inspect
  end

  def create
    # Find user to log in if not going through omniauth
    if params[:user]
      user = User.find_by(name: params[:user][:name])
      @user = user.try(:authenticate, params[:user][:password])

      # if user doesn't exist redirect back to login
      if !@user
        flash[:msg] = "#{params[:user][:name]} not found or bad password."
        return redirect_to root_path
      end
    else
      
      # If going through 3rd party find_or_create by uid
      @user = User.find_or_create_by_omniauth(auth_hash)
    end
    log_in
    password_msg
    redirect_to user_path(@user)
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def log_in
    session[:user_id] = @user.id
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def password_msg
    flash[:msg] = "Please contact admin to access password." if @user.password_digest == "newuser"
  end

end
