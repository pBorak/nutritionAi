class User < ApplicationRecord
  has_secure_password
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/.freeze

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true, format: EMAIL_REGEX, presence: true
  validates :password, length: { minimum: 6 }, presence: true
end
