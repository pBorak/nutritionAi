class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/.freeze

  has_one :profile, dependent: :destroy
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true, format: EMAIL_REGEX, presence: true
  validates :password, length: { minimum: 6 }, presence: true, allow_nil: true
end
