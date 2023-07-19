class User < ApplicationRecord
  has_many :accounts
  has_many :categories
  has_many :credit_cards
  has_many :transactions
end
