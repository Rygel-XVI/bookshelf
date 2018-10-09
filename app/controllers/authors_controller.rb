class AuthorsController < ApplicationController
  before_action :redirect_unless_logged_in

  def index
    @authors = Author.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @authors.to_json(only: [:name, :id])}
    end
  end

  def show
    set_author
    @books = @author.books.uniq
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @books.to_json(only: [:title, :description, :status, :word_count])}
    end
  end

  def author_book_data
    set_author
    @books = @author.books.uniq
    render @books.json
  end

end
