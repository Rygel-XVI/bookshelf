class Admin::AuthorsController < ApplicationController
  before_action :admin_required

  def edit
    @author = Author.find(params[:id])
  end

end
