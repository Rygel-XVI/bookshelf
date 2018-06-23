class UsersController < ApplicationController

  def index
    if current_user.admin
      @user = current_user
      @users = User.all
      @books = Book.all
      @author = Author.all
    else
      redirect_to user_path(current_user)
    end

  end

  def show
    @user = current_user
    @books = @user.books
  end

  def new
    @user = User.new
  end


#combine session#create with this at some point
  def create
    if User.find_by(name: params[:user][:name])
      # @user = User.find_by(name: params[:user][:name])
      ##flash error message user already exists
      @user = User.new
      render new_user_path
    else
      @user = User.new(user_params(params[:user]))
      if @user.save
        render login(@user)
        redirect_to user_path(@user)
      end
      render new_user_path
    end
  end

  def edit
    @user = current_user
  end

  def destroy

  end

  private

  def user_params(args)
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
