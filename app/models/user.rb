class User < ApplicationRecord
  # before_action :require_login
  # skip_before_action :require_login, only: [:index]

  has_secure_password

  def self.find_or_create_from_auth_hash(auth_hash)
    byebug
  end

end
