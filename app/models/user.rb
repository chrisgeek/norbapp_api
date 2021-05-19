class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many_attached :photos, dependent: :destroy
  has_and_belongs_to_many :groups, optional: true
  has_many :pending_requests

  VALID_ROLES = %w[super_admin admin member].freeze
  VALID_GENDERS = %w[male female].freeze
  VALID_STATUS = %w[single married divorced].freeze

  validates :role, inclusion: { in: VALID_ROLES }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true, inclusion: { in: VALID_GENDERS }
  validates :status, presence: true, inclusion: { in: VALID_STATUS }
  validates :phone, presence: true
                    # uniqueness: { scope: :group_id, message: 'Phone number already exists' }
  validates :bio, presence: true
  validates :dob, presence: true
  validates :address, presence: true
  validates :photos, attached: true, content_type: %i[png jpg jpeg],
                     size: { less_than_or_equal_to: 5.megabytes },
                     limit: { min: 1, max: 4 }
  validates :email, presence: true
                    # uniqueness: { scope: :group_id, message: 'Email already exist' }
end
