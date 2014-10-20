Marketplace::Application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :people, path: 'users', only: [:show]
  resources :people, only:  [:create, :update, :destroy]
  resources :users
  resources :projects
  resources :memberships
  resources :taggings, only: [ :create, :update, :destroy, :show ]
  resources :durations, only: [ :create, :update, :destroy, :show ]

  resources :tags, only: [ :index, :show, :update, :destroy ]
  resources :activities, only: [ :index ]
  post "/tags/merge_tags", to: "tags#merge_tags", as: 'merge_tags'
  get "/tags/autocomplete/results.json", to: "tags#autocomplete"
  devise_scope :user do
    get "users/auth/google_oauth2/callback", to: "oauth#google"
  end
  get "/cvs", to: "cvs#index", as: 'cvs'



  namespace :news do
    get "/", to: "items#index"
  end

  scope '/api', defaults: { format: :json } do
    namespace :news do
      resources :items
    end
  end


end
