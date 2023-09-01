Rails.application.routes.draw do
  passwordless_for :users, at: '/'

  get 'notifications/index'

  get "t/sitemap", to: "sitemap#index", as: :sitemap, defaults: { format: "xml" }

  get 'users/header', to: 'users#header', as: :users_header
  get 'users/timeline_nav', to: 'users#timeline_nav', as: :users_timeline_nav
  get '/users/code_theme', to: 'users#code_theme', as: :users_code_theme
  get 'users/wallpaper', to: 'users#wallpaper', as: :users_wallpaper
  get 'sign_up', to: 'users#new', as: :sign_up
  post 'users/confirm', to: 'users#confirm', as: :confirm
  get 'users/register/:token', to: 'users#register', as: :register
  post 'users', to: 'users#create', as: :create_user
  delete 'users/:id', to: 'users#destroy', as: :delete_user

  get '/notifications', to: 'notifications#index', as: :notifications

  root 'posts#index'
  get "/latest", to: "posts#latest", as: :latest
  get "/pinned", to: "posts#pinned", as: :pinned
  get "posts/form", to: "posts#form", as: :post_form
  get "posts/:id", to: "posts#show", as: :post
  post "posts", to: "posts#create", as: :create_post
  patch "posts/:id", to: "posts#update", as: :update_post
  delete "posts/:id", to: "posts#destroy", as: :delete_post
  get "posts/:id/main", to: "posts#main", as: :post_main
  get '/posts/:id/pin_button', to: 'posts#pin_button', as: :post_pin_button
  get 'posts/:id/editor', to: 'posts#editor', as: :post_editor
  get 'posts/:id/menu', to: 'posts#menu', as: :post_menu

  get 'posts/:post_id/cheers', to: 'cheers#index', as: :cheers
  post 'posts/:post_id/cheers', to: 'cheers#create', as: :create_cheer
  delete 'posts/:post_id/cheers/:id', to: 'cheers#destroy', as: :delete_cheer
  patch 'posts/:post_id/cheers/:id', to: 'cheers#update', as: :update_cheer
  get 'posts/:post_id/cheers/:id/editor', to: 'cheers#editor', as: :cheer_editor
  get 'posts/:post_id/cheers/form', to: 'cheers#form', as: :cheer_form
  get 'posts/:post_id/cheers/count', to: 'cheers#count', as: :cheers_count

  post '/posts/:post_id/pins', to: 'pins#create', as: :create_pin
  delete '/posts/:post_id/pins/:id', to: 'pins#destroy', as: :delete_pin

  get '/posts/:post_id/reactions', to: 'post_reactions#index', as: :post_reactions
  post '/posts/:post_id/reactions', to: 'post_reactions#create', as: :create_post_reaction
  delete '/posts/:post_id/reactions/:id', to: 'post_reactions#destroy', as: :delete_post_reaction

  get '/posts/:post_id/comments', to: 'comments#index', as: :comments
  post '/posts/:post_id/comments', to: 'comments#create', as: :create_comment
  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: :delete_comment
  patch '/posts/:post_id/comments/:id', to: 'comments#update', as: :update_comment
  get '/posts/:post_id/comments/form', to: 'comments#form', as: :comment_form

  post '/posts/:post_id/comments/:comment_id/reactions', to: 'comment_reactions#create', as: :create_comment_reaction
  delete '/posts/:post_id/comments/:comment_id/reactions/:id', to: 'comment_reactions#destroy', as: :delete_comment_reaction

  get '/posts/:post_id/cheers/:cheer_id/reactions', to: 'cheer_reactions#index', as: :cheer_reactions
  post '/posts/:post_id/cheers/:cheer_id/reactions', to: 'cheer_reactions#create', as: :create_cheer_reaction
  delete '/posts/:post_id/cheers/:cheer_id/reactions/:id', to: 'cheer_reactions#destroy', as: :delete_cheer_reaction
  
  get 'settings', to: 'settings#edit', as: :settings
  get 'settings/export', to: 'settings#export', as: :export_settings
  get 'settings/exports/:id/download', to: 'settings#download_export', as: :download_export
  patch 'settings/profile', to: 'settings#update_profile', as: :update_profile
  patch 'settings/theme', to: 'settings#update_theme', as: :update_theme
  patch 'settings/access_token', to: 'settings#update_access_token', as: :update_access_token

  get 'privacy/(:locale)', to: 'pages#privacy', as: :privacy
  get 'terms/(:locale)', to: 'pages#terms', as: :terms
  get 'about/(:locale)', to: 'pages#about', as: :about
  get 'docs/(:locale)', to: 'pages#docs', as: :docs

  get '/.well-known/webfinger', to: 'webfinger#index', as: :webfinger

  get '/:username', to: 'users#actor', as: :actor, constraints: lambda { |request| request.format == :json }
  get '/:username', to: 'users#show', as: :user, constraints: lambda { |request| request.format != :json }
  get '/:username/feed', to: 'users#feed', as: :feed
  get 'users/:username' => redirect('/%{username}')
  get '/:username/profile', to: 'users#profile', as: :profile
  get '/:username/projects', to: 'projects#index', as: :projects
  get '/:username/projects/list', to: 'projects#list', as: :projects_list
  get '/:username/projects/:codename', to: 'projects#show', as: :project
  get 'projects/new', to: 'projects#new', as: :new_project
  post 'projects', to: 'projects#create', as: :create_project
  get '/:username/projects/:codename/edit', to: 'projects#edit', as: :edit_project
  get '/:username/projects/:codename/details', to: 'projects#details', as: :project_details
  patch '/:username/projects/:id', to: 'projects#update', as: :update_project
  delete '/:username/projects/:codename', to: 'projects#destroy', as: :delete_project
  post '/:username/follows', to: 'follows#create', as: :follow_user
  delete '/:username/follows', to: 'follows#destroy', as: :unfollow_user
  get '/:username/followers', to: 'users#followers', as: :followers
  get '/:username/following', to: 'users#following', as: :following
  get '/:username/images', to: 'users#images', as: :images
  get '/:username/user_nav', to: "users#user_nav", as: :user_nav
  get '/:username/follow_nav', to: "users#follow_nav", as: :follow_nav

  namespace :api do
    namespace :v1 do
      get 'posts', to: 'posts#index', as: :posts
      get 'posts/following', to: 'posts#following', as: :posts_following
      get 'posts/trending', to: 'posts#trending', as: :posts_trending
      get 'posts/pinned', to: 'posts#pinned', as: :posts_pinned
      get 'posts/search', to: 'posts#search', as: :posts_search
      get 'posts/:id', to: 'posts#show', as: :post
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
