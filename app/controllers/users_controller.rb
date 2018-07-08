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

      # turn into elsif #somemethod to move logic out of controller?
    else
      @user = User.new(user_params)
      User.not_omniauth_creation
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


# Add stats for Accelerated Reader level once add :ar_level to books
  def show
    set_user
    @checked_out_books = @user.get_checked_out_books

    @read_books = @user.get_read_books
    @read_books.uniq! {|b| b.title}

    @avg_word_count = Book.avg_words(@read_books)
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
