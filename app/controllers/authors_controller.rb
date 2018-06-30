class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    # @empty_authors = Author.no_books(@authors)
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

end
