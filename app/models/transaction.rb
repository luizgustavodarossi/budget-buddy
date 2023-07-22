class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :account
  belongs_to :credit_card
end
