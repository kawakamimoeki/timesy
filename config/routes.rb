Rails.application.routes.draw do
  get 'notifications/index'

  get "t/sitemap", to: "sitemap#index", as: :sitemap, defaults: { format: "xml" }

  get 'users/header', to: 'users#header', as: :users_header
  get 'users/sign_up', to: 'users#new', as: :sign_up
  post 'users/confirm', to: 'users#confirm', as: :confirm
  get 'users/register/:token', to: 'users#register', as: :register
  post 'users', to: 'users#create', as: :create_user
  delete 'users/:id', to: 'users#destroy', as: :delete_user

  get '/notifications', to: 'notifications#index', as: :notifications

  root 'posts#index'
  get "/latest", to: "posts#latest", as: :latest
  get "/pined", to: "posts#pinned", as: :pinned
  get "/trending", to: "posts#trending", as: :trending
  get "/search", to: "search#index", as: :search
  get "posts/:id", to: "posts#show", as: :post
  post "posts", to: "posts#create", as: :create_post
  patch "posts/:id", to: "posts#update", as: :update_post
  delete "posts/:id", to: "posts#destroy", as: :delete_post

  post '/posts/:post_id/pins', to: 'pins#create', as: :create_pin
  delete '/posts/:post_id/pins/:id', to: 'pins#destroy', as: :delete_pin

  post '/posts/:post_id/reactions', to: 'post_reactions#create', as: :create_post_reaction
  delete '/posts/:post_id/reactions/:id', to: 'post_reactions#destroy', as: :delete_post_reaction
  get '/posts/:post_id/reactions/list', to: 'post_reactions#list', as: :post_reactions_list

  get '/posts/:post_id/comments', to: 'comments#index', as: :comments
  post '/posts/:post_id/comments', to: 'comments#create', as: :create_comment
  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: :delete_comment
  patch '/posts/:post_id/comments/:id', to: 'comments#update', as: :update_comment
  get '/posts/:post_id/comments/:id/comment_editor', to: 'comments#comment_editor', as: :comment_editor

  post '/posts/:post_id/comments/:comment_id/reactions', to: 'comment_reactions#create', as: :create_comment_reaction
  delete '/posts/:post_id/comments/:comment_id/reactions/:id', to: 'comment_reactions#destroy', as: :delete_comment_reaction
  get '/posts/:post_id/comments/:comment_id/reactions/list', to: 'comment_reactions#list', as: :comment_reactions_list
  
  get 'settings', to: 'settings#edit', as: :settings
  get 'settings/export', to: 'settings#export', as: :export_settings
  get 'settings/exports/:id/download', to: 'settings#download_export', as: :download_export
  patch 'settings/profile', to: 'settings#update_profile', as: :update_profile
  patch 'settings/theme', to: 'settings#update_theme', as: :update_theme
  patch 'settings/webhook', to: 'settings#update_webhook', as: :update_webhook
  patch 'settings/access_token', to: 'settings#update_access_token', as: :update_access_token

  get 'privacy', to: 'pages#privacy', as: :privacy
  get 'terms', to: 'pages#terms', as: :terms
  get 'about' => redirect('https://about.timesy.dev')
  get 'docs' => redirect('https://about.timesy.dev/docs')

  get '/.well-known/webfinger', to: 'webfinger#index', as: :webfinger

  get '/:username', to: 'users#actor', as: :actor, constraints: lambda { |request| request.format == :json }
  get '/:username', to: 'users#show', as: :user, constraints: lambda { |request| request.format != :json }
  get 'users/:username' => redirect('/%{username}')
  get '/:username/projects', to: 'projects#index', as: :projects
  get '/:username/projects/:codename', to: 'projects#show', as: :project
  get '/:username/comments', to: 'users#comments', as: :user_comments
  get 'projects/new', to: 'projects#new', as: :new_project
  post 'projects', to: 'projects#create', as: :create_project
  get '/:username/projects/:codename/edit', to: 'projects#edit', as: :edit_project
  patch '/:username/projects/:id', to: 'projects#update', as: :update_project
  delete '/:username/projects/:codename', to: 'projects#destroy', as: :delete_project
  post '/:username/follows', to: 'follows#create', as: :follow_user
  delete '/:username/follows', to: 'follows#destroy', as: :unfollow_user
  get '/:username/followers', to: 'users#followers', as: :followers
  get '/:username/following', to: 'users#following', as: :following

  namespace :api do
    namespace :v1 do
      post 'posts', to: 'posts#create', as: :create_post
      patch 'posts/:id', to: 'posts#update', as: :update_post
      delete 'posts/:id', to: 'posts#destroy', as: :delete_post
      post 'comments/previews', to: 'comments#preview', as: :preview_comment
      post 'posts/:post_id/comments', to: 'comments#create', as: :create_comment
      patch 'posts/:post_id/comments/:id', to: 'comments#update', as: :update_comment
      delete 'posts/:post_id/comments/:id', to: 'comments#destroy', as: :delete_comment
      post 'projects/previews', to: 'projects#preview', as: :preview_project
      post 'projects', to: 'projects#create', as: :create_project
      patch 'projects/:id', to: 'projects#update', as: :update_project
      delete 'projects/:id', to: 'projects#destroy', as: :delete_project
      post 'posts/preview', to: 'posts#preview', as: :preview_post
      get 'blobs/:id/url', to: 'blobs#url', as: :blob_url
      post 'notifications/read', to: 'notifications#read', as: :read_notifications
    end
  end
end
