class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :accounts
  has_many :categories
  has_many :credit_cards
  has_many :transactions
end
