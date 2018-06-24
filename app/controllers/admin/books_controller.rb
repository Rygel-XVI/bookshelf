class Admin::BooksController < ApplicationController
  before_action :admin_required

  def edit
    @book = Book.find(params[:id])
  end

end
