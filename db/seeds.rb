# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Channel.destroy_all
DirectMessage.destroy_all

5.times do |index|
  User.create(name: "User #{index}", email: "email#{index}@gmail.com", password: "password")
end

5.times do |index|
  Channel.create(name: "Channel #{index}")
end

first_user = User.first
first_channel = Channel.first

Channel.all.each do |channel|
  first_user.channels << channel
end

User.all.each do |user|
  if !first_channel.user_ids.include? user.id
    first_channel.users << user
  end
  if user.id != first_user.id
    DirectMessage.create(
      sender_id: first_user.id,
      recipient_id: user.id,
      content: "Message between user #{first_user.id} and user #{user.id}",
    )
  end
end
