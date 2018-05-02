Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#home'
  post '/oauth/request_token' => 'sessions#new'
  get '/auth/:provider/callback' => 'sessions#create'

  # get '/auth/google_oath2/callback' => 'sessions#create'
  get '/sessions/login' => 'sessions#new'
  get '/auth/failure' => 'sessions#fail'
  resources :users

end
