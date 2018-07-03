class AuthorsController < ApplicationController
  before_action :redirect_unless_logged_in

  def index
    @authors = Author.all
  end

  def show
    set_author
    @books = @author.books
  end

end
