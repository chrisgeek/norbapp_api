class SubscriptionList < ApplicationRecord
  has_many :subscriptions
  validates :name, presence: true, uniqueness: true
  validates :user_limit, presence: true, uniqueness: true
  validates :price, presence: true, uniqueness: true
end
