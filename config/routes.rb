Rails.application.routes.draw do

# 管理者側のログイン
devise_for :admin, controllers: {
  sessions: 'admin/sessions',
}

# 管理者側のルーティング設定
namespace :admin do
  get 'top' => 'homes#top', as: 'top'
  # 検索に関するルーティング
  get '/search' => 'search#search'
  resources :end_users, only: [:index, :show]
  resources :blogs, only: [:index, :show]
end

# エンドユーザー側のルーティング設定
devise_for :end_users, controllers: {
  sessions: 'public/sessions',
  registrations: 'public/registrations',
}

scope module: :public do
  # 非登録ユーザーが唯一見られるフロントページ
  root 'fronts#top'
  get '/about' => 'fronts#about'
  # ログイン後のトップページ
  get 'end_users/home' => 'homes#top'
  get 'end_users/about' => 'homes#about'

  # 検索に関するルーティング設定
  get '/search' => 'search#search'

  # エンドユーザーに関するルーティング
  resources :end_users, only: [:index, :show, :edit, :update] do
    resource :relationships, only:[:index, :create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
    collection do
      # 退会確認ページ
      get 'unsubscribe' => 'end_users#unsubscribe'
      # 退会処理を行うルーティング
      patch 'withdraw' => 'end_users#withdraw'
      post 'withdraw' => 'end_users#withdraw'
    end
  end

  # 投稿に関するルーティング
  resources :blogs do
    # いいね機能
    resource :likes, only: [:create, :destroy]
    # コメント機能
    resources :comments, only: [:create, :destroy]
    # ブックマーク機能
    resource :bookmarks, only: [:create, :destroy]
  end

  # タグ検索に関するルーティング
  resources :tags do
    get '/search' => 'blogs#search'
  end
end
end
