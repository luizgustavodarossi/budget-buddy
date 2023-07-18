Rails.application.routes.draw do
  resources :users
  resources :transactions
  resources :credit_cards
  resources :accounts
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
