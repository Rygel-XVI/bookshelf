class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    if @book.status == "Checked Out" || @book.status == "Available"
      @userbook = UserBook.find_by(book_id: @book.id, user_id: current_user.id)
      if !!@userbook && @userbook.status != "Checked Out"
        # @render_button = 'checkout'
        @button = "Check Out"
      elsif !!@userbook && @userbook.status == "Checked Out"
        # @render_button = 'return'
        @button = "Return Book"
      end
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
