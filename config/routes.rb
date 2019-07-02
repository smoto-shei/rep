Rails.application.routes.draw do

  root 'toppages#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  resources :toppages, only: :index do
    collection do
      get 'column'
      get 'a_column'
      get 'privacy_policy'
      get 'regulation'
      get 'contact_us'
      get 'administrator_info'
    end
  end

  resources :users, only: [:index, :show] do
    member do      #id含む
      get 'records_update'
    end
    collection do  #id含まない
      get 'pagination'
    end
    resources :images, except: [:new, :show]
    resources :user_bodies, only: [:new, :create, :update]
    resources :training_records, only: [:index, :create, :destroy] do
      collection do
        get :draw_graph
      end
    end
  end

  resources :exercises, only: :index

  resources :relationships, only: [:create, :destroy]

end
