class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :accountable

  enum kind: [:visa, :mastercard, :american_express, :diners_club, :discover, :other]

  validates :name, presence: true
  validates :kind, presence: true
  validates :balance, presence: true
  validates :closes_day, presence: true
  validates :expire_day, presence: true
end
