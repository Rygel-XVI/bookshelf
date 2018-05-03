class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render '/sessions/login'
  end

  def fail
    raise params.inspect
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    byebug
    self.current_user = @user
    redirect_to root_path
  end

  private

  def auth_hash
    # raise params.inspect
    request.env['omniauth.auth']
  end

end
