module UsersHelper

  def current_user
    User.find(session[:user_id])
  end

  def user_id
    current_user.id
  end

  def user_password_label
    current_user.admin ? "Admin Password" : "Current Password"
  end

end
