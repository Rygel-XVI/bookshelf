module ApplicationHelper

  def logged_in?
    !!session[:user_id]
  end

  def is_admin?
    current_user.admin
  end

end
