class Transaction < ApplicationRecord
  belongs_to :categories
  belongs_to :accounts
  belongs_to :credit_cards
end
