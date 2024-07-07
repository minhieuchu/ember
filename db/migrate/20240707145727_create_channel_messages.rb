class CreateChannelMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :channel_messages do |t|
      t.integer :user_id
      t.integer :channel_id
      t.string :content

      t.timestamps
    end
  end
end
