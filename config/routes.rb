Rails.application.routes.draw do
  root 'toppages#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  resources :users do
    member do      #id含む
      get 'records_update'
    end
    collection do  #id含まない
      get 'pagination'
    end
    resources :images
    resources :user_bodies
    resources :training_records do
      collection do
        get :draw_graph
      end
    end
  end

  resources :exercises, only: :index

  resources :relationships, only: [:create, :destroy]

  get 'toppage/column', to: 'toppages#column' #のちにcolumnテーブル作ったらルーティング修正
  get 'toppage/a_column', to: 'toppages#a_column' #のちにcolumnテーブル作ったらルーティング修正
  get 'toppage/privacy_policy', to: 'toppages#privacy_policy' #のちにcolumnテーブル作ったらルーティング修正
  get 'toppage/regulation', to: 'toppages#regulation' #のちにcolumnテーブル作ったらルーティング修正


end
