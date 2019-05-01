Rails.application.routes.draw do
  resources :watch_histories,   only: [:index, :update]
  resources :favorites,         only: [:create, :destroy]
  resources :people,            only: [:edit, :update]
  resources :video_comments,    only: [:create, :update, :destroy]
  resources :profile_comments,  only: [:create, :update, :destroy]
  resources :movie_ratings,     only: [:create, :update, :destroy]
  resources :movie_actors,      only: [:create, :update, :destroy]
  resources :movie_genres,      only: [:create, :update, :destroy]
  resources :movies,            except: [:index]
  resources :episodes,          except: [:index, :show]
  resources :videos,            only: [:show]
  resources :show_actors,       only: [:create, :update, :destroy]
  resources :show_ratings,      only: [:create, :update, :destroy]
  resources :show_genres,       only: [:create, :update, :destroy]
  resources :shows,             except: [:index]
  resources :subscriptions,     only: [:create, :update]
  resources :customers,         except: [:index, :edit, :update]
  resources :producers,         except: [:index, :edit, :update]
  resources :friend_requests,   only: [:create, :update, :destroy]
  root    'static_pages#home'
  get     '/about',   to: 'static_pages#about'
  get     '/contact', to: 'static_pages#contact'
  get     '/browse',  to: 'static_pages#browse'
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
  get     '/my_rentals',  to: 'static_pages#my_rentals'
  post    '/movies/:id/rent', to: 'rentals#create'
  get     '/invoice', to: 'static_pages#invoice'
end
