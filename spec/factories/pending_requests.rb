FactoryBot.define do
  factory :pending_request do
    association :group
    association :user
  end
end
