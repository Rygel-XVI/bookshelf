class Admin::AuthorsController < ApplicationController
  before_action :admin_required

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
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to authors_path(@author)
    else
      render 'edit'
    end
  end

  def destroy
    author = Author.find(params[:id])
    author.destroy
    redirect_to authors_path
  end


  private

  def author_params
    params.require(:author).permit(:name)
  end

end
