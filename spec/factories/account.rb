FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    kind { Account.kinds.keys.sample }
    balance { Faker::Number.decimal(l_digits: 2) }
    user
  end
end
