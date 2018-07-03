class User < ApplicationRecord
  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
  require "securerandom"
  has_secure_password

  has_many :user_books
  has_many :books, through: :user_books

  validates :name, presence: true
  validates :name, uniqueness: true

  validates_confirmation_of :password, :if => :password_present?
  validates_presence_of :password, :on => :create, :unless => :uid

  # if uid on creation redirect to view that has you set a password OR set a simple password on creation like 123

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true

end
