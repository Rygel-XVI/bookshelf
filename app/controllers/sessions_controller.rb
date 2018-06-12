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
    binding.pry
    @user = User.find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    binding.pry
    redirect_to root_path
  end

  private

  def auth_hash
    # raise params.inspect
    request.env['omniauth.auth']
  end

end
