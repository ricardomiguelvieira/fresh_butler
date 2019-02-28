Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :users do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:create, :show]
  end
  resources :bookings, except: [:new, :create]
  get "/profile", to: "pages#profile"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
