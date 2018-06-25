class Admin::BooksController < ApplicationController
  before_action :admin_required

  def new
    @book = Book.new
    @book.build_author
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      # add success msg
      redirect_to admin_books_path
    else
      # add error msg
      render new_admin_book_path(@book)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :word_count, :status, :author_id, author_attributes: [:id, :name])
  end
end
