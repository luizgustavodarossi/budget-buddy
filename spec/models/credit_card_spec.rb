require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it 'belongs to a user' do
    credit_card = CreditCard.reflect_on_association(:user)
    expect(credit_card.macro).to eq(:belongs_to)
  end

  it 'has many transactions' do
    credit_card = CreditCard.reflect_on_association(:transactions)
    expect(credit_card.macro).to eq(:has_many)
  end
end
