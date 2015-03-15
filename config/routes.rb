Rails.application.routes.draw do
  get 'profiles/edit'

  get 'profiles/update'

  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  resource :profile, only: [:edit, :update]
end
