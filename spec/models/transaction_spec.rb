require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it 'validates presence of description' do
      transaction = build :transaction, description: nil
      expect(transaction).to_not be_valid
    end

    it 'validates presence of kind' do
      transaction = build :transaction, kind: nil
      expect(transaction).to_not be_valid
    end

    it 'validates presence of amount' do
      transaction = build :transaction, amount: nil
      expect(transaction).to_not be_valid
    end

    it 'validates amount is greater than 0' do
      transaction = build :transaction, amount: 0
      expect(transaction).to_not be_valid
    end

    it 'validates presence of emitted_at' do
      transaction = build :transaction, emitted_at: nil
      expect(transaction).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      transaction = Transaction.reflect_on_association(:user)
      expect(transaction.macro).to eq(:belongs_to)
    end

    it 'belongs to a category' do
      transaction = Transaction.reflect_on_association(:category)
      expect(transaction.macro).to eq(:belongs_to)
    end

    it 'belongs to an accountable polymorphic' do
      transaction = Transaction.reflect_on_association(:accountable)
      expect(transaction.macro).to eq(:belongs_to)
      expect(transaction.options[:polymorphic]).to eq(true)
    end
  end

  describe 'enums' do
    it 'has the correct values' do
      expect(Transaction.kinds.keys).to eq(%w[expense income transfer])
    end
  end
end
