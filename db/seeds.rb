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

5.times do |index|
  User.create(name: "User #{index}", email: "email#{index}@gmail.com", password: "password")
end

5.times do |index|
  Channel.create(name: "Channel #{index}")
end

user = User.first
channel = Channel.first

Channel.all.each do |channel|
  user.channels << channel
end

User.all.each do |user|
  channel.users << user
end
