FactoryBot.define do
  factory :group do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence }
    # user
  end
end
