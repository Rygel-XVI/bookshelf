Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'
  post '/oauth/request_token' => 'sessions#new'
  get '/auth/:provider/callback' => 'sessions#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/sessions/login' => 'sessions#new'
  get '/auth/failure' => 'sessions#fail'

  resources :users, :books, :authors

end
