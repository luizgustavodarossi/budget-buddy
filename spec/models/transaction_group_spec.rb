require 'rails_helper'

RSpec.describe TransactionGroup, type: :model do
  it 'has many transactions' do
    transaction_group = TransactionGroup.reflect_on_association(:transactions)
    expect(transaction_group.macro).to eq(:has_many)
  end
end
