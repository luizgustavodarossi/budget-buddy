class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :accountable

  enum kind: [:cash, :checking, :investment, :saving, :other]

  validates :name, presence: true
  validates :kind, presence: true
end
