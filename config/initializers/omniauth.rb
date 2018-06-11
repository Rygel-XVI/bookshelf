Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, "API_KEY", "API_SECRET"

  provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']
# end
