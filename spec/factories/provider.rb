FactoryBot.define do
    factory :provider do
      title { Faker::Lorem.sentence }
      name { Faker::Lorem.sentence }
      public_key { "public_key" }
      association :business, factory: :business
    end
end