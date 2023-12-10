class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  enum kind: [:income, :expense]

  validates :name, presence: true
  validates :kind, presence: true

  scope :incomes, -> { where(kind: :income) }
  scope :expenses, -> { where(kind: :expense) }
  scope :search, ->(search) { where("name LIKE ?", "%#{search}%") }
end
