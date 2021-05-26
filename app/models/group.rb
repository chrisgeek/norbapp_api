class Group < ApplicationRecord
  # before_save :set_group_admin
  after_create :create_subscription
  resourcify
  has_and_belongs_to_many :users
  has_many :pending_requests
  has_one :subscription, dependent: :destroy
  has_one :subscription_list, through: :subscription

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  # def set_group_admin
  #   user.update(role: 'admin')
  # end

  def create_subscription
    create_subscription!(subscription_list_id: SubscriptionList.where(name: 'Free').first.id)
  end
end
