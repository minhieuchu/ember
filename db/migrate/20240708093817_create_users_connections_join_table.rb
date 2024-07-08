class CreateUsersConnectionsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :users_connections, id: false do |t|
      t.belongs_to :user_a, null: false, foreign_key: {to_table: :users}
      t.belongs_to :user_b, null: false, foreign_key: {to_table: :users}

      t.index [:user_a_id, :user_b_id], unique: true
      t.index [:user_b_id, :user_a_id], unique: true
    end
  end
end
