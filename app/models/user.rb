class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  has_and_belongs_to_many :channels, join_table: :users_channels
  has_many :sent_messages, class_name: :DirectMessage, foreign_key: "sender_id"
  has_many :received_messages, class_name: :DirectMessage, foreign_key: "recipient_id"
  has_many :users_connections_a, class_name: :UsersConnection, foreign_key: "user_a_id"
  has_many :users_connections_b, class_name: :UsersConnection, foreign_key: "user_b_id"

  scope :find_by_email, ->(email) { where(email: email).first }

  def as_json(options = {})
    super(options.merge(except: [:password_digest, :created_at, :updated_at]))
  end
end
