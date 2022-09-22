Rails.application.routes.draw do
  resources :baggages
  resources :users
  resources :reservations
  resources :flights
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
