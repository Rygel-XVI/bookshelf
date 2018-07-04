class BooksController < ApplicationController
  before_action :redirect_unless_logged_in

  def index
    @books = Book.all
  end

  def show
    set_book
    if @book.status != "Not Available"
     @userbook = find_userbook || @userbook = UserBook.new

      set_button_form_locals

    end
  end

  def update
    set_book
    check_userbook_status = true if @book.status == "Checked Out"
    if @book.update(book_params)
      if check_userbook_status
        @userbook = find_userbook
        @userbook.update(status: "Returned") if @userbook.status == "Checked Out"
      end
      redirect_to book_path(@book)
    else
      render edit_admin_book_path(@book)
    end
  end

  private

# Finds UserBook that matches logged in users library book
# This is private because admin may need a different method and it is only used here
  def find_userbook
    UserBook.find_by(book_id: @book.id, user_id: current_user.id)
  end

  def book_params
    params.require(:book).permit(:status, user_books_attributes: [
      :status,
      :user_id,
      :book_id,
      :id
      ])
  end

end
