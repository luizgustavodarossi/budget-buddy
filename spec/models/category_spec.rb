require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'belongs to a user' do
    category = Category.reflect_on_association(:user)
    expect(category.macro).to eq(:belongs_to)
  end

  it 'has many transactions' do
    category = Category.reflect_on_association(:transactions)
    expect(category.macro).to eq(:has_many)
  end
end
