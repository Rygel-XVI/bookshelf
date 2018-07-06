class Admin::BooksController < ApplicationController
  before_action :redirect_unless_logged_in, :admin_required

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:msg] = "#{@book.title} Created"
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  def edit
    set_book
  end

  def update
    set_book
    if @book.update(book_params)
      flash[:msg] = "#{@book.title} Update Successful!"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

# Change method so it checks if it has any UserBooks and if those have actual Users associated before deleting

####### TEST THIS OUT MORE

  def destroy
    set_book
    if !@book.user_books.empty?
      @userbooks = @book.user_books
      if @userbooks.detect {|ub| User.find(ub.user_id)}
        @book.update(status: "Graveyard")
        flash[:msg] = "Cannot delete go talk to Annette if you need to delete it. Status changed to Graveyard instead."
      end
    else
      @book.destroy
      flash[:msg] = "#{@book.title} has been deleted."
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :word_count, :status, :author_id, author_attributes: [:id, :name])
  end
end
