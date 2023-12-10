class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :accountable, polymorphic: true

  enum kind: [:expense, :income, :transfer]

  validates :description, presence: true
  validates :kind, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :emitted_at, presence: true

  scope :search, ->(search) { where("description LIKE ?", "%#{search}%") }
end
