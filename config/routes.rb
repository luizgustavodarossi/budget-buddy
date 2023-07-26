Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :transactions
  resources :credit_cards
  resources :accounts
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "transactions#index"
end
