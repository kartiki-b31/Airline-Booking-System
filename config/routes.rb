Rails.application.routes.draw do
    get 'static_pages/home'
    resources :baggages
    resources :users
    resources :reservations
    resources :flights
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    root 'home#index'

    resources :sessions, only: [:new, :create, :destroy]
    get 'signup', to: "users#new", as: 'signup'
    get 'login', to: "sessions#new", as: 'login'
    get 'logout', to: "sessions#destroy", as: 'logout'
end
