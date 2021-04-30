Rails.application.routes.draw do
  resources :posts do
    resources :likes
    resources :comments
  end
  
  #root('static#home')
  root('posts#topups')
  get '/about', to: 'static#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  get '/topups', to: 'posts#topups', as: 'topups'
  get '/kups', to: 'posts#kups', as: 'kups'
  get '/newups', to: 'posts#newups', as: 'newups'
  get '/search', to: 'posts#search', as: 'search'
end
