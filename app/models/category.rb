class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  enum kind: [:income, :expense]

  validates :name, presence: true
  validates :kind, presence: true
end
