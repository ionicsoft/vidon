Rails.application.routes.draw do
  resources :people
  resources :video_comments
  resources :profile_comments
  resources :movie_ratings
  resources :movie_actors
  resources :movie_genres
  resources :movies
  resources :episodes
  resources :videos
  resources :show_actors
  resources :show_ratings
  resources :show_genres
  resources :shows
  resources :subscriptions
  resources :customers
  resources :payments
  resources :producers
  resources :friend_requests
  root    'static_pages#home'
  get     '/about',   to: 'static_pages#about'
  get     '/contact', to: 'static_pages#contact'
  get     '/signup',  to: 'customers#new'
  get     '/psignup', to: 'producers#new'
  get     '/search',  to: 'static_pages#search', :as => 'search_page'
  get     '/myshows', to: 'static_pages#shows',  :as => 'my_shows'
  get     '/pro_shows', to: 'static_pages#_pro_shows'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  get     '/friends', to: 'static_pages#friends'
  delete  '/friends/:id', to: 'friends#destroy'
end
