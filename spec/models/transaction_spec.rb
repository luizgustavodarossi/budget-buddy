require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'belongs to a user' do
    transaction = Transaction.reflect_on_association(:user)
    expect(transaction.macro).to eq(:belongs_to)
  end

  it 'belongs to a category' do
    transaction = Transaction.reflect_on_association(:category)
    expect(transaction.macro).to eq(:belongs_to)
  end

  it 'belongs to an account' do
    transaction = Transaction.reflect_on_association(:account)
    expect(transaction.macro).to eq(:belongs_to)
  end

  it 'belongs to a credit card' do
    transaction = Transaction.reflect_on_association(:credit_card)
    expect(transaction.macro).to eq(:belongs_to)
  end
end
