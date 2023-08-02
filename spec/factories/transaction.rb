FactoryBot.define do
  factory :transaction do
    description { Faker::Lorem.sentence }
    kind { Transaction.kinds.keys.sample }
    observation { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2) }
    emitted_at { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    category
    user
    association :accountable, factory: :account
  end
end
