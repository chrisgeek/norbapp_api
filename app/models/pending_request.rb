class PendingRequest < ApplicationRecord
  belongs_to :group
  belongs_to :user
end