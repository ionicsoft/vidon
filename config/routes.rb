Rails.application.routes.draw do
  resources :account_activations, only: [:edit]
  resources :customers,         except: [:index, :edit, :update]
  resources :episodes,          except: [:index, :show]
  resources :favorites,         only: [:create, :destroy]
  resources :friend_requests,   only: [:create, :update, :destroy]
  resources :movie_actors,      only: [:create, :update, :destroy]
  resources :movie_genres,      only: [:create, :update, :destroy]
  resources :movie_ratings,     only: [:create, :update, :destroy]
  resources :movies,            except: [:index]
  resources :payments,          only: [:edit, :update]
  resources :people,            only: [:edit, :update]
  resources :producers,         except: [:index, :edit, :update]
  resources :profile_comments,  only: [:create, :update, :destroy]
  resources :show_actors,       only: [:create, :update, :destroy]
  resources :show_genres,       only: [:create, :update, :destroy]
  resources :show_ratings,      only: [:create, :update, :destroy]
  resources :shows,             except: [:index]
  resources :subscriptions,     only: [:create, :update]
  resources :video_comments,    only: [:create, :update, :destroy]
  resources :videos,            only: [:show]
  resources :watch_histories,   only: [:index, :update]
  
  root    'static_pages#home'
  
  get     '/about',           to: 'static_pages#about'
  get     '/browse',          to: 'static_pages#browse'
  get     '/contact',         to: 'static_pages#contact'
  delete  '/friends/:id',     to: 'friends#destroy'
  get     '/friends',         to: 'static_pages#friends'
  get     '/invoice',         to: 'static_pages#invoice'
  get     '/login',           to: 'sessions#new'
  post    '/login',           to: 'sessions#create'
  delete  '/logout',          to: 'sessions#destroy'
  post    '/movies/:id/rent', to: 'rentals#create'
  get     '/my_rentals',      to: 'static_pages#my_rentals'
  get     '/myshows',         to: 'static_pages#shows',  :as => 'my_shows'
  get     '/pro_shows',       to: 'static_pages#_pro_shows'
  get     '/psignup',         to: 'producers#new'
  get     '/search',          to: 'static_pages#search', :as => 'search_page'
  get     '/signup',          to: 'customers#new'
end
