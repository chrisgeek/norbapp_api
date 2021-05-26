class PendingRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
  scope :pending, -> { where(status: 'pending') }

  VALID_STATUS = %w[pending approved declined].freeze
  validates :status, presence: true, inclusion: { in: VALID_STATUS }
end
