class User < ApplicationRecord
  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
  require "securerandom"

  has_secure_password


end
