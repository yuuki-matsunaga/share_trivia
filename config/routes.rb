Rails.application.routes.draw do

  devise_for :users
  root to:"homes#top"
  get 'about' => 'homes#about'
  get 'users/confirm' => 'users#confirm'
  patch 'users/withdraw' => 'users#withdraw'

  #relationships は中間テーブルなので、usersモデルにネストさせる
  resources :users, only: [:index,:show,:edit, :update] do
    resource :relationships, only: [:create, :destroy]
  #followingsとfollowersは一覧ページ用に定義するアクション
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts
  resources :genres,only: [:index,:create,:edit,:update]
  resources :likes
  resources :favorites

end
