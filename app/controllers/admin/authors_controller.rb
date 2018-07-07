class Admin::AuthorsController < ApplicationController
  before_action :redirect_unless_logged_in, :admin_required

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to authors_path(@author)
    else
      render 'new'
    end
  end

  def edit
    set_author
  end

  def update
    set_author
    if @author.update(author_params)
      redirect_to authors_path(@author)
    else
      render 'edit'
    end
  end

# Add logic to check to make sure the author has no books associated with it

  def destroy
    set_author
    @author.destroy
    flash[:msg] = "#{@author.name} has been deleted."
    redirect_to authors_path
  end


  private

  def author_params
    params.require(:author).permit(:name)
  end

end
