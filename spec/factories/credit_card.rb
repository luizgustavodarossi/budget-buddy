FactoryBot.define do
  factory :credit_card do
    name { Faker::Name.name }
    kind { CreditCard.kinds.keys.sample }
    balance { Faker::Number.decimal(l_digits: 2) }
    closes_day { Faker::Number.between(from: 1, to: 28) }
    expire_day { Faker::Number.between(from: 1, to: 28) }
    user
  end
end
