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
      flash[:msg] = "Error #{@book.title} not created"
      render new_admin_book_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render edit_admin_book_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :word_count, :status, :author_id, author_attributes: [:id, :name])
  end
end
