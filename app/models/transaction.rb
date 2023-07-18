class Transaction < ApplicationRecord
  belongs_to :categories
  belongs_to :accounts
end
