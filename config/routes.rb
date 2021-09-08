Rails.application.routes.draw do

  devise_for :users
  root to:"homes#top"
  get 'about' => 'homes#about'
  resources :users
  resources :posts
  resources :genres
  resources :likes
  resources :favorites
  resources :relationships





end
