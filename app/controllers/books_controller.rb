class BooksController < ApplicationController
  before_action :redirect_unless_logged_in

  def index
    @books = Book.all

    # @checked_out = current_user.user_books.find_by(status: "Checked Out")
    # @read = current_user.user_books.find_by(status: "Read")
    # @not_read = current_user.user_books.find_by(status: "Not Read")
    @checked_out = current_user.user_books.find_all {|userbook| userbook.status == "Checked Out"}
    @checked_out.map! {|userbook| Book.find(userbook.book_id)}

    @read = current_user.user_books.find_all {|userbook| userbook.status == "Read"}
    @read.map! {|userbook| Book.find(userbook.book_id)}

    @not_read = current_user.user_books.find_all {|userbook| userbook.status == "Not Read"}
    @not_read.map! {|userbook| Book.find(userbook.book_id)}


    binding.pry
  end

  def show
    set_book
    if @book.status != "Not Available"
     @userbook = find_userbook || @userbook = UserBook.new

# Mehods in application_controller
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
      render book_path(@book)
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
