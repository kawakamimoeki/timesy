Rails.application.routes.draw do
  passwordless_for :users

  get 'users/sign_up', to: 'users#new', as: :sign_up
  post 'users/confirm', to: 'users#confirm', as: :confirm
  get 'users/register/:token', to: 'users#register', as: :register
  post 'users', to: 'users#create', as: :create_user
  delete 'users/:id', to: 'users#destroy', as: :delete_user

  root 'posts#index'
  get "posts/:id", to: "posts#show", as: :post
  post "posts", to: "posts#create", as: :create_post
  patch "posts/:id", to: "posts#update", as: :update_post
  delete "posts/:id", to: "posts#destroy", as: :delete_post

  post '/posts/:post_id/reactions', to: 'post_reactions#create', as: :create_post_reaction
  delete '/posts/:post_id/reactions/:id', to: 'post_reactions#destroy', as: :delete_post_reaction

  post '/posts/:post_id/comments', to: 'comments#create', as: :comments
  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: :delete_comment
  patch '/posts/:post_id/comments/:id', to: 'comments#update', as: :update_comment

  post '/posts/:post_id/comments/:comment_id/reactions', to: 'comment_reactions#create', as: :create_comment_reaction
  delete '/posts/:post_id/comments/:comment_id/reactions/:id', to: 'comment_reactions#destroy', as: :delete_comment_reaction
  
  get 'settings', to: 'settings#edit', as: :settings
  get 'settings/export', to: 'settings#export', as: :export_settings
  get 'settings/exports/:id/download', to: 'settings#download_export', as: :download_export
  patch 'settings', to: 'settings#update', as: :update_settings
  
  get 'search', to: 'posts#search', as: :search

  get 'privacy', to: 'pages#privacy', as: :privacy
  get 'terms', to: 'pages#terms', as: :terms
  get 'about', to: 'pages#about', as: :about

  get '/.well-known/webfinger', to: 'webfinger#index', as: :webfinger

  get '/:username', to: 'users#actor', as: :actor, constraints: lambda { |request| request.format == :json }
  get '/:username', to: 'users#show', as: :user, constraints: lambda { |request| request.format != :json }
  get 'users/:username' => redirect('/%{username}')

  namespace :api do
    namespace :v1 do
      post 'posts/preview', to: 'posts#preview', as: :preview_post
    end
  end
end
