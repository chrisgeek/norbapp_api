class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :role, :phone, :gender, :status, :bio, :confirmed, :email, :id
  has_many :groups
end
