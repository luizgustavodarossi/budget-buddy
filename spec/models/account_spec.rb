require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'belongs to a user' do
    account = Account.reflect_on_association(:user)
    expect(account.macro).to eq(:belongs_to)
  end

  it 'has many transactions' do
    account = Account.reflect_on_association(:transactions)
    expect(account.macro).to eq(:has_many)
  end
end
