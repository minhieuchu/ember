class Channel < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_channels

  scope :find_by_user_id, ->(user_id) { joins(:users).where(users: { id: user_id }) }

  def as_json(options = {})
    super(options.merge(
      except: [:created_at, :updated_at],
      include: {
        users: { except: [:password_digest, :created_at, :updated_at] },
      },
    ))
  end
end
