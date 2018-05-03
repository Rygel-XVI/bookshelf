Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#home'

  # get '/sessions/login' => 'sessions#login'
  # get '/auth/:provider/callback' => 'sessions#create'
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


end
