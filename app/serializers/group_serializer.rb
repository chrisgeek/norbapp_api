class GroupSerializer
  include JSONAPI::Serializer
  attributes :name
  has_one :subscription
  has_many :users, serializer: UserSerializer
end
