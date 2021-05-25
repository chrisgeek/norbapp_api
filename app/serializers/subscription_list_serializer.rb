class SubscriptionListSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :user_limit
end
