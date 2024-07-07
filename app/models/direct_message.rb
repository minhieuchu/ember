class DirectMessage < ApplicationRecord
  belongs_to :sender, class_name: :User, foreign_key: "sender_id"
  belongs_to :recipient, class_name: :User, foreign_key: "recipient_id"

  validates :content, presence: true

  scope :chat_between, ->(user1_id, user2_id) {
      DirectMessage.where(sender_id: user1_id, recipient_id: user2_id)
        .or(DirectMessage.where(sender_id: user2_id, recipient_id: user1_id))
        .order(created_at: :asc)
    }
end
