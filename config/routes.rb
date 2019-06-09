Rails.application.routes.draw do
  root 'toppages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get 'records_update'
    end
    resources :user_bodies
    resources :training_records do
      collection do
        get :draw_graph
      end
    end
  end

  get 'toppage/column', to: 'toppages#column' #のちにcolumnテーブル作ったらルーティング修正


end
