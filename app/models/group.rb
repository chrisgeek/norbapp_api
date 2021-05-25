class Group < ApplicationRecord
  # before_save :set_group_admin
  has_and_belongs_to_many :users
  has_many :pending_requests
  has_one :subscription, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :admin_id, presence: true

  def set_group_admin
    user.update(role: 'admin')
  end
end
