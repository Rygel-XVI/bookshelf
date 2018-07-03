module ApplicationHelper

  def logged_in?
    !!session[:user_id]
  end

  def is_admin?
    current_user.admin
  end

  def book_title
    @book.title
  end

  def user_name(user)
    user.name
  end

end
