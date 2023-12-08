Rails.application.routes.draw do
  devise_for :users, controller: { sessions: "users/sessions" }

  resources :transactions
  resources :credit_cards
  resources :accounts
  resources :categories

  root "transactions#index"
end
