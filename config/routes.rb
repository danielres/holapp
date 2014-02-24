Marketplace::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :people, only:  [:create]
  resources :users
  resources :projects
  resources :memberships
end

