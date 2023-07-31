class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :accountable

  enum kind: [:cash, :checking, :investment, :saving, :other]

  validates :name, presence: true
  validates :kind, presence: true

  # Adicionando algumas violações de estilo
  before_validation :ensure_name_capitalized
  after_create :log_account_creation

  def ensure_name_capitalized
    self.name = name.capitalize
  end

  def log_account_creation
    Rails.logger.info("New account created with ID: #{id}")
  end
end
