FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    kind { Category.kinds.keys.sample }
    user
  end
end
