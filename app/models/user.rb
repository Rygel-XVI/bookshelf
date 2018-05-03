class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2, :tumblr, :twitter, :github]


# auth.uid = rygel-xvi  teach-with-your-hands
# auth.info.avatar = profile pic
# auth.info.nickname = nickname
# auth.info.name = name


   def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    byebug
  end

end
