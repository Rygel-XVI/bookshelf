Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
    :name => "google",
    :scope => "userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50
  }
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']
# end
