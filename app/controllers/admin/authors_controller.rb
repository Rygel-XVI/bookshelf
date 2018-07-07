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
    if @author.destroy_if_empty
      flash[:msg] = "#{@author.name} has been deleted."
      redirect_to authors_path
    else
      flash[:msg] = "#Error #{@author.name} not deleted"
      redirect_to edit_admin_author_path(@author)
    end
  end


  private

  def author_params
    params.require(:author).permit(:name)
  end

end
