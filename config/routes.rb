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

  get '/author/:id/book_data' => 'authors#book_data'
  get '/author/:id/author_data' => 'authors#author_data'

  resources :users, except: [:index, :destroy]

  resources :books, :authors, only: [:index, :show, :update]

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :books, except: [:index, :show]
    resources :authors, except: [:index, :show]
  end

end
