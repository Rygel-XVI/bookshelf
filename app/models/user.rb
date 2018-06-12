class User < ApplicationRecord
  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
  require "securerandom"

  has_secure_password

  def self.find_or_create_from_auth_hash(auth_hash)
    u = User.new
    u.email = auth_hash[:info][:email]
    u.name = auth_hash[:info][:name]
    u.password = SecureRandom.base64(15)
    u.save
    u
  end

end
