Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {:provider_ignores_state => true}
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :tumblr, ENV['TUMBLR_KEY'], ENV['TUMBLR_SECRET']
# end
