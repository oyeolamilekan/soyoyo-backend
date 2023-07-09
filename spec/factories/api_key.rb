FactoryBot.define do
    factory :api_key do
        private_key { Faker::Name.name }
        public_key { Faker::Name.name }
    end
end
  