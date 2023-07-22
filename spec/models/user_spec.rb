require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has many credit cards' do
    user = User.reflect_on_association(:credit_cards)
    expect(user.macro).to eq(:has_many)
  end

  it 'has many accounts' do
    user = User.reflect_on_association(:accounts)
    expect(user.macro).to eq(:has_many)
  end

  it 'has many categories' do
    user = User.reflect_on_association(:categories)
    expect(user.macro).to eq(:has_many)
  end

  it 'has many transactions' do
    user = User.reflect_on_association(:transactions)
    expect(user.macro).to eq(:has_many)
  end
end
