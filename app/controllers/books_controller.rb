class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    if @book.status != "Not Available"
     @userbook = UserBook.find_by(book_id: @book.id, user_id: current_user.id) || @userbook = UserBook.new()

      # # binding.pry
      # if !!@userbook

        if @book.status == "Checked Out" && @userbook.status == "Checked Out"
            @button = "Return Book"
            @global_status = "Available"
            @user_status_choice = true
            binding.pry

        elsif @book.status == "Available"
            @button = "Check Out"
            @global_status = "Checked Out"
            @user_status_choice = false
            binding.pry

        end

      # end
    end
    binding.pry

  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book)
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
