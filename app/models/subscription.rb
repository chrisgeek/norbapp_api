class Subscription < ApplicationRecord
  belongs_to :subscription_list
  belongs_to :group
end
