Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }


  root to:"homes#top"
  get 'about' => 'homes#about'
  get 'users/confirm' => 'users#confirm'
  patch 'users/withdraw' => 'users#withdraw'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

  #relationships は中間テーブルなので、usersモデルにネストさせる
  resources :users, only: [:index,:show,:edit, :update] do
    get 'level_up' => 'users#level_up', as: 'level_up'
    get :favorites, on: :collection
  #マイページのルーティングにネスト

    resource :relationships, only: [:create, :destroy]
  #followingsとfollowersは一覧ページ用に定義するアクション
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :goods,only: [:create,:destroy]
  resources :genres,only: [:index,:create,:edit,:update]

  resources :posts do
    resources :comments, only: [:create, :destroy]#コメント機能
    resource :favorites, only: [:create, :destroy]
  # お気に入り機能.記事詳細表示のルーティングにネスト

    # match 'search' => 'posts#search', via: [:get, :post]
    #検索機能用
    get 'posts_search' => 'posts#search', as: 'search'
  end

  resources :notifications, only: :index

end
