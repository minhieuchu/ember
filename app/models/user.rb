class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  has_and_belongs_to_many :channels, join_table: :users_channels

  scope :find_by_email, ->(email) { where(email: email).first }
end
