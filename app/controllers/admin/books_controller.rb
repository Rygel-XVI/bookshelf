class Admin::BooksController < ApplicationController
  before_action :admin_required

  def new
    @book = Book.new
    @book.build_author
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
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:msg] = "#{@book.title} Update Successful!"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:msg] = "#{book.title} has been deleted."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :word_count, :status, :author_id, author_attributes: [:id, :name])
  end
end
