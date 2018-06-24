class Admin::BooksController < ApplicationController
  before_action :admin_required

  def new
    @book = Book.new
    @book.build_author
  end

  def create
    binding.pry
    @book = Book.new(book_params)
  end

  def edit
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :word_count, :status, :author_id, author_attributes: [:name, :id])
  end
end
