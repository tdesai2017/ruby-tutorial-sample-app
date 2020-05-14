Rails.application.routes.draw do
  

  get 'sessions/new'

  root "static_pages#home"
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destory'
  resources :users do
    member do
      # creates urls /users/1/following and users/1/followers
      # the actions of these paths are 'following' and 'followers'
      # the names of these paths = 'following_user_path(1)' and 'followers_user_path(1)'
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
