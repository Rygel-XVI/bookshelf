class Admin::BooksController < ApplicationController
  before_action :redirect_unless_logged_in, :admin_required

  def new
    # make accessible by json
    book = Book.new
    render json: book.to_json
  end

  def create
    @book = Book.new(book_params)
    @book.number = Book.get_highest_number(@book.title)
    if @book.save
      flash.now[:msg] = "#{@book.title} Created"
      # change redirect to instead return json and add it to the list
      render json: @book.to_json(include: :author)
      # redirect_to book_path(@book)
    else
      render 'new'
    end
  end


# Add:
# Assigning who a book is checked out to in the future
# Returning a book that is checked out from any user
  def edit
    set_book
  end

  def update
    set_book
    if @book.update(book_params)
      flash.now[:msg] = "#{@book.title} Update Successful!"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    set_book
    if !@book.can_destroy?
      @book.update(status: "Graveyard")
      flash.now[:msg] = "Cannot delete go talk to Annette if you need to delete it. Status changed to Graveyard instead."
    else
      @book.destroy
      flash.now[:msg] = "#{@book.title} has been deleted."
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :word_count, :status, :author_id, author_attributes: [:id, :name])
  end
end
