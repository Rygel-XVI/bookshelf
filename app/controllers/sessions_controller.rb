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
    @user = User.find_or_create_by(uid: auth_hash[:uid]) do |u|
      u.email = auth_hash[:info][:email]
      u.name = auth_hash[:info][:name]
      u.password = SecureRandom.base64(15)
      u.uid = auth_hash[:uid]
    end
    login(@user)
    redirect_to user_path(@user)
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end
