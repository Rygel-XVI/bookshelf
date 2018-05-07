class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    raise params.inspect
  end

##not using as no email provided in uid complicates validation
  # def tumblr
  #   byebug
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   byebug
  #   sign_in_and_redirect @user
  # end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def github
    raise params.inspect
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
