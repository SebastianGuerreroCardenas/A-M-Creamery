Rails.application.routes.draw do
  # Routes for main resources
  resources :stores
  resources :employees
  resources :assignments
  resources :users
  resources :sessions
  resources :flavors
  resources :jobs
  resources :users
  resources :shifts



  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'dashboard' => 'home#dashboard', as: :dashboard

  get 'user/edit/:id' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  
  get 'edit_store_flavor/:id' => 'stores#edit_store_flavor', :as => :edit_store_flavor

  # Set the root url
  root :to => 'home#home'  
  
end
