class AuthorsController < ApplicationController

  def index
    @authors = Author.all
  end

  def show
    set_author
    @books = @author.books
  end

end
