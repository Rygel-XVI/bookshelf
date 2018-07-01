class BooksController < ApplicationController

  def index
    binding.pry
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @userbook = UserBook.where(book_id: @book.id, user_id: current_user.id)
    if !!@userbook && @userbook.status != "Checked Out"
      @render_button = 'checkout'
    elsif !!@userbook && @userbook.status == "Checked Out"
      @render_button = 'return'
    end
  end

  def update
    # have to add tracking of which user has the book checked out and add the status of the user_book (ie user library). :checked out, :read

    # User.first.user_books.first.status

    binding.pry
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:status, :user_books_attributes [:status, :user_id, :book_id, :id])
  end

end
