FactoryBot.define do
  factory :payment_page do
    title { Faker::Lorem.sentence }
    link { Faker::Alphanumeric.alpha(number: 10) }
    amount { 2000 }
    status { :enabled }
    association :business, factory: :business
  end
end
