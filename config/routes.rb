Rails.application.routes.draw do
  passwordless_for :users

  get 'users/sign_up', to: 'users#new', as: :sign_up
  post 'users/confirm', to: 'users#confirm', as: :confirm
  get 'users/register/:token', to: 'users#register', as: :register
  post 'users', to: 'users#create', as: :create_user
  delete 'users/:id', to: 'users#destroy', as: :delete_user

  root 'posts#index'
  get "posts/:id", to: "posts#show", as: :post
  post "new-post", to: "posts#create", as: :create_post
  patch "posts/:id", to: "posts#update", as: :update_post
  delete "posts/:id", to: "posts#destroy", as: :delete_post

  post '/posts/:post_id/comments', to: 'comments#create', as: :comments
  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: :delete_comment
  patch '/posts/:post_id/comments/:id', to: 'comments#update', as: :update_comment
  
  get 'users/:username', to: 'users#show', as: :user
  
  get 'settings', to: 'settings#edit', as: :settings
  patch 'settings', to: 'settings#update', as: :update_settings
  
  get 'search', to: 'posts#search', as: :search

  get 'privacy', to: 'pages#privacy', as: :privacy
  get 'terms', to: 'pages#terms', as: :terms
  get 'about', to: 'pages#about', as: :about
end
