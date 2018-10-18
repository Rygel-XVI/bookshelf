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
    # make this uniq by name
    # @books.uniq {|b| b.title }
    @books = @author.books.uniq {|b| b.title }
    # format.html { render :show }
  end

  def author_data
    set_author
    render json: @author.to_json
  end

  def book_data
    set_author
    @books = @author.books.uniq
    render json: @books.to_json(only: [:id, :title, :description, :status, :word_count])
  end

end
