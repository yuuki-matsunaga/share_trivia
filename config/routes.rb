Rails.application.routes.draw do

  devise_for :users
  root to:"homes#top"
  get 'about' => 'homes#about'
  get 'users/confirm' => 'users#confirm'
  patch 'users/withdraw' => 'users#withdraw'
  resources :users, only: [:index,:show, :edit, :update]
  resources :posts
  resources :genres
  resources :likes
  resources :favorites
  resources :relationships





end
