FactoryBot.define do
    factory :business do
      title { Faker::Lorem.sentence }
      association :user, factory: :user
    end
end