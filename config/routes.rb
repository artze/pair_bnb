Rails.application.routes.draw do

  root 'static#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resources :users, controller: 'users', only: [:create, :edit, :update] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
    resources :listings, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :reservations, only: [:index, :show, :destroy]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/auth/:provider/callback', to: 'sessions#create_from_omniauth'

  resources :listings, only: [:index, :show] do
    resource :reservation, only: [:new, :create]
    get 'search', on: :collection
  end

  resources :reservations, only: [] do
    resource :payment, only: [:new]
    post 'payment/checkout', to: 'payments#checkout'
  end

end