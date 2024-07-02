class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  scope :find_by_email, ->(email) { where(email: email).first }
end
