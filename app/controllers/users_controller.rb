class UsersController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    sanitize(params[:user])
    if User.find_by(name: params[:user][:name])
      @user = User.new
      render new_user_path
    else
      @user = User.new(user_params)
      if @user.save
        flash[:msg] = "#{@user.name} Creation Successful! Login to continue."
        return redirect_to login_path
      end
      render 'new'
    end
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.authenticate(params[:old_password]) && @user.update(user_params)
      flash[:msg] = "#{@user.name} Update Successful"
      redirect_to user_path(@user)
    else
      flash[:msg] = "#{@user.name} Not Updated"
      render 'edit'
    end
  end

  def show
    set_user
    @books = @user.books
  end

  def destroy
    set_user
    @user.destroy
    redirect_to logout_path
  end

  private

  def sanitize(input)
    input.values.each {|i| i.strip!}
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
