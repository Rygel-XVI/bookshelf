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

  def show
    set_user
    @read = @user.user_books.where(status: "Read").uniq

    # Gets average word count fromo all read books
    @read_userbooks = @user.user_books.where(status: "Read")
    @read_books = @read_userbooks.map {|userbook| Book.find_by(id: userbook.book_id)}.uniq
    @avg_word_count = avg_words(@read_books)

    @checked_out_userbooks = @user.user_books.where(status: "Checked Out")
    @checked_out_books = @checked_out_userbooks.map {|userbook| Book.find_by(id: userbook.book_id)}.uniq

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

  def avg_words(books)
    words = 0
    if books.size > 0
      books.map {|book| words += book.word_count}
      words =  words/books.size
    else
      words
    end
  end

end
