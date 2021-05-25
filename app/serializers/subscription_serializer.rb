class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes
  belongs_to :group
  belongs_to :subscription_list
end
