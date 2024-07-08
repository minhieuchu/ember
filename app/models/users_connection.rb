class UsersConnection < ApplicationRecord
  belongs_to :user_a, class_name: :User, foreign_key: "user_a_id"
  belongs_to :user_b, class_name: :User, foreign_key: "user_b_id"

  scope :find_by_user, ->(user_id) {
          UsersConnection.where(user_a_id: user_id)
            .or(UsersConnection.where(user_b_id: user_id))
        }
end
