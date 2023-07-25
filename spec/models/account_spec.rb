require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      account = build :account, name: nil
      expect(account).to_not be_valid
    end

    it 'validates presence of kind' do
      account = build :account, kind: nil
      expect(account).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      account = Account.reflect_on_association(:user)
      expect(account.macro).to eq(:belongs_to)
    end

    it 'has many transactions with accountable' do
      account = Account.reflect_on_association(:transactions)
      expect(account.macro).to eq(:has_many)
      expect(account.options[:as]).to eq(:accountable)
    end
  end

  describe 'enums' do
    describe 'kind' do
      it 'has the correct values' do
        expect(Account.kinds.keys).to eq(%w[cash checking investment saving other])
      end
    end
  end
end
