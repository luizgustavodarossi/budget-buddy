require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      category = build :category, name: nil
      expect(category).to_not be_valid
    end

    it 'validates presence of kind' do
      category = build :category, kind: nil
      expect(category).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      category = Category.reflect_on_association(:user)
      expect(category.macro).to eq(:belongs_to)
    end

    it 'has many transactions' do
      category = Category.reflect_on_association(:transactions)
      expect(category.macro).to eq(:has_many)
    end
  end

  describe 'enums' do
    describe 'kind' do
      it 'has the correct values' do
        expect(Category.kinds.keys).to eq(%w[income expense])
      end
    end
  end
end
