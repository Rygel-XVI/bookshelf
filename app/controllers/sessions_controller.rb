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
    @user = User.find_or_create_from_auth_hash(auth_hash)
    binding.pry
    login(@user)
    redirect_to user_path(@user)
  end

  # something closer to this
  # def create
  #   @user = User.find_or_create_by(uid: auth['uid']) do |u|
  #     u.name = auth['info']['name']
  #     u.email = auth['info']['email']
  #     u.image = auth['info']['image']
  #   end
  #
  #   session[:user_id] = @user.id
  #
  #   render 'welcome/home'
  # end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  # def login(user)
  #   binding.pry
  # end

  def auth_hash
    # raise params.inspect
    request.env['omniauth.auth']
  end

end
