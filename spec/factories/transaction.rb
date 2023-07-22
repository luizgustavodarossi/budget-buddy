FactoryBot.define do
  factory :transaction do
    description { Faker::Lorem.sentence }
    observation { Faker::Lorem.sentence }
    amount_to_pay { Faker::Number.decimal(2) }
    amount_paid { Faker::Number.decimal(2) }
    due_at { Faker::Date.between(2.days.ago, Date.today) }
    paid_at { Faker::Date.between(2.days.ago, Date.today) }
    account
    category
    user
  end
end
