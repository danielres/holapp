Marketplace::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :people, path: 'users', only: [:show]
  resources :people, only:  [:create, :update]
  resources :users
  resources :projects
  resources :memberships
end
