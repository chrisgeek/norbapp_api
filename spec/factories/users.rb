FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.unique.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { 'male' }
    status { 'married' }
    phone { Faker::Number.leading_zero_number(digits: 11) }
    role { 'member' }
    bio { Faker::Lorem.sentences(number: 3) }
    association :group

    trait :super_admin do
      role { 'super_admin' }
    end

    trait :admin do
      role { 'admin' }
    end
  end
end
