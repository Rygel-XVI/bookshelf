class SessionsController < ApplicationController

  def new
    render '/sessions/login'
  end

  def fail
    raise params.inspect
  end

  def create
    raise params.inspect
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to root_path
  end

  private

  def auth_hash
    raise params.inspect
    request.env['omniauth.auth']
  end

end
