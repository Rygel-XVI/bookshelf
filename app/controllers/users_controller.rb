class UsersController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: [:new, :create]

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
      ##flash error message user already exists
      @user = User.new
      render new_user_path
    else
      @user = User.new(user_params(params[:user]))
      if @user.save
        return redirect_to login_path
      end
      # flash msg invalid field
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
