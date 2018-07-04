class UsersController < ApplicationController
  before_action :redirect_unless_logged_in
  skip_before_action :redirect_unless_logged_in, only: [:new, :create]

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

    if valid_pass? && user_updated?
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
    binding.pry
    @userlibrary = UserBook.find_all {|userbook| userbook.user_id == @user.id}

    binding.pry
  end

  def destroy
    set_user
    if @user.destroy
      flash[:msg] = "#{@user.name} Destroyed"
      redirect_to logout_path
    else
      flash[:msg] = "User not deleted please notify admin"
      redirect_to user_path(@user)
    end
  end

  private

  def sanitize(input)
    input.values.each {|i| i.strip!}
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def default_pass?
    @user.password_digest == "newuser"
  end

  def valid_pass?
    default_pass? || @user.authenticate(params[:old_password])
  end

  def user_updated?
    @user.update(user_params)
  end

end
