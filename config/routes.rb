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
  resources :genres,only: [:index,:create,:edit,:update]

  resources :posts do
    resources :comments, only: [:create, :destroy]#コメント機能
    # get 'posts_search' => 'posts#search', as: 'search'
    match 'search' => 'items#search', via: [:get, :post]
  end


  resources :goods,only: [:create,:destroy] #いいね機能
  resources :favorites,only: [:create,:destroy] #お気に入り機能

end
