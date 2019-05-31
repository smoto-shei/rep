Rails.application.routes.draw do
  root 'toppages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  as :user do
    get '/user/show' => 'users#show'
  end

end
