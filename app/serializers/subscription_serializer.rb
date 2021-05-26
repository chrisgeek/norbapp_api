class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :renewed_at
  belongs_to :group
  belongs_to :subscription_list
end
