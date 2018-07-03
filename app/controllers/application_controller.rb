class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # returns currently logged in user
  def current_user
    User.find(session[:user_id])
  end

  # logs user in
  def login(user)
    session[:user_id] = user.id
  end

  # checks if someone is logged in
  def logged_in?
    !!session[:user_id]
  end

  # checks if currently logged in user is admin
  def is_admin?
    logged_in? && current_user.admin
  end



######## Before_action methods ########

  # redirects to root view unless logged in

  # add if current_user and !!logged_in? session.clear
  def redirect_unless_logged_in
    redirect_to root_path unless logged_in? && !!current_user
  end

  # redirects away unless current user is admin
  def admin_required
   return head(:forbidden) unless current_user.admin
  end



#########  These methods set variables  #########

  # sets @user to logged in user
  def set_user
    @user = current_user
  end

  # sets @book
  def set_book
    @book = Book.find(params[:id])
  end

  # sets author
  def set_author
    @author = Author.find(params[:id])
  end

  # Stuff for checkout/return button

  def can_return?
    @Book.status == "Checked Out" && @user_books.status == "Checked Out"
  end

  def set_submit_message
    can_return? ? "Check Out" : "Return Book"
  end

  def change_book_status
    @book.status == "Available" ? "Checked Out" : "Available"
  end

  def user_book_status_options?
    @book.status == "Available" ?  false  : true
  end

  def set_button_form_locals
    @button = set_submit_message
    @global_status = change_book_status
    @user_status_choice = user_book_status_options
  end

end
