class User < ApplicationRecord
  require "securerandom"
  has_secure_password
  before_validation :no_password_omniauth

  validates_presence_of :password, :on => :create, :if => :password_required?

  # validates_confirmation_of :password, :if => :password_present?
  validates_presence_of :password, :on => :create, :unless => :uid

  has_many :user_books
  has_many :books, through: :user_books

  validates :name, presence: true
  validates :name, uniqueness: true


  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true

  $called_omniauth = false

  def self.set_omniauth
    $called_omniauth = true
  end

  def no_password_omniauth
    self.password_digest = 'newuser' unless password_required?
  end

  def password_required?
    !$called_omniauth
  end

end
