class User < ApplicationRecord
  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
  require "securerandom"
  has_secure_password

  has_many :user_books
  has_many :books, through: :user_books

end
