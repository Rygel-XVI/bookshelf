class SessionsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def new
    @user = User.new
    render '/sessions/login'
  end

  def fail
    raise params.inspect
  end

  def create
    if params[:user]
      user = User.find_by(name: params[:user][:name])
      @user = user.try(:authenticate, params[:user][:password])
      if !!@user
        flash[:msg] = "#{params[:user][:name]} not found or bad password."
        return redirect_to root_path
      end
    else
      @user = User.find_or_create_by(uid: auth_hash[:uid]) do |u|
        u.email = auth_hash[:info][:email]
        u.name = auth_hash[:info][:name]
        u.password = SecureRandom.base64(15)
        u.uid = auth_hash[:uid]
      end
    end
    log_in
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

end
