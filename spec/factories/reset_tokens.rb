FactoryBot.define do
  factory :reset_token do
    link { Faker::Alphanumeric.alpha(number: 10) }
    association :user, factory: :user
  end
end
