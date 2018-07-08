class User < ApplicationRecord
  require "securerandom"
  has_secure_password
  before_validation :no_password_omniauth

# This is necessary to create users through the two paths properly
  validates_presence_of :password, :on => :create, :if => :password_required?

# These make it so updating user info runs the proper validations
  validates_presence_of :password, on: :update
  validates_confirmation_of :password, on: :update

  has_many :user_books
  has_many :books, through: :user_books

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true

####### Methods and constant that interact with validations
  $called_omniauth = false

  def self.not_omniauth_creation
    $called_omniauth = false
  end

  def self.omniauth_creation
    $called_omniauth = true
  end

  def no_password_omniauth
    self.password_digest = 'newuser' unless password_required?
  end

  def password_required?
    !$called_omniauth
  end

  def self.find_or_create_by_omniauth(auth_hash)
    User.omniauth_creation
    where(uid: auth_hash[:uid]).first_or_create do |u|
      u.email = auth_hash[:info][:email]
      u.name = auth_hash[:info][:name]
      u.uid = auth_hash[:uid]
    end
  end

end
