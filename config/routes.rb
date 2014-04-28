Marketplace::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :people, path: 'users', only: [:show]
  resources :people, only:  [:create, :update, :destroy]
  resources :users
  resources :projects
  resources :memberships
  resources :taggings, only: [ :create, :update, :destroy ]
  resources :tags, only: [ :index, :show, :update, :destroy ]
  get "/tags/autocomplete/results.json", to: "tags#autocomplete"
end
