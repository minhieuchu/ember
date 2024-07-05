class CreateUsersChannelsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :users_channels, id: false do |t|
      t.belongs_to :user
      t.belongs_to :channel
    end
  end
end
