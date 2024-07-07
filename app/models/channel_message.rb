class ChannelMessage < ApplicationRecord
  belongs_to :user, class_name: :User, foreign_key: "user_id"
  belongs_to :channel, class_name: :Channel, foreign_key: "channel_id"

  validates :content, presence: true

  scope :find_by_channel, ->(channel_id) { where(channel_id: channel_id).order(created_at: :asc) }
end
