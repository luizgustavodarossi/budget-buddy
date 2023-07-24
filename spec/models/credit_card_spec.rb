require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      credit_card = build :credit_card, name: nil
      expect(credit_card).to_not be_valid
    end

    it 'validates presence of kind' do
      credit_card = build :credit_card, kind: nil
      expect(credit_card).to_not be_valid
    end

    it 'validates presence of balance' do
      credit_card = build :credit_card, balance: nil
      expect(credit_card).to_not be_valid
    end

    it 'validates presence of closes_day' do
      credit_card = build :credit_card, closes_day: nil
      expect(credit_card).to_not be_valid
    end

    it 'validates presence of expire_day' do
      credit_card = build :credit_card, expire_day: nil
      expect(credit_card).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      credit_card = CreditCard.reflect_on_association(:user)
      expect(credit_card.macro).to eq(:belongs_to)
  end

    it 'has many transactions with accountable' do
      credit_card = CreditCard.reflect_on_association(:transactions)
      expect(credit_card.macro).to eq(:has_many)
      expect(credit_card.options[:as]).to eq(:accountable)
    end
  end

  describe 'enums' do
    describe 'kind' do
      it 'has the correct values' do
        expect(CreditCard.kinds.keys).to eq(%w[visa mastercard american_express diners_club discover other])
      end
    end
  end
end
