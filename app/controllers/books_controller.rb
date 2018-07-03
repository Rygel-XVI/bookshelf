class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    set_book
    if @book.status != "Not Available"
     @userbook = UserBook.find_by(book_id: @book.id, user_id: current_user.id) || @userbook = UserBook.new()

        if @book.status == "Checked Out" && @userbook.status == "Checked Out"
            @button = "Return Book"
            @global_status = "Available"
            @user_status_choice = true

        elsif @book.status == "Available"
            @button = "Check Out"
            @global_status = "Checked Out"
            @user_status_choice = false

        end

    end
  end

  def update
    set_book
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render edit_admin_book_path(@book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:status, user_books_attributes: [
      :status,
      :user_id,
      :book_id,
      :id
      ])
  end

end
