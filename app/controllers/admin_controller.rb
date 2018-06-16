class AdminController < ApplicationController
  before_action: admin_required

  def index
    if current_user.admin
      @user = current_user
      @users = User.all
      @books = Book.all
      @author = Author.all
    else
      redirect_to user_path(current_user)
    end
  end

  def edit_user

  end

  def edit_book

  end

  def edit_author

  end

  private

  def admin_required
   return head(:forbidden) unless current_user.admin    
  end

end
