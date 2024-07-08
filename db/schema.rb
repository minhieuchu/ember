# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_08_093817) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channel_messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "channel_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "direct_messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_channels", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "channel_id"
    t.index ["channel_id"], name: "index_users_channels_on_channel_id"
    t.index ["user_id"], name: "index_users_channels_on_user_id"
  end

  create_table "users_connections", id: false, force: :cascade do |t|
    t.bigint "user_a_id", null: false
    t.bigint "user_b_id", null: false
    t.index ["user_a_id", "user_b_id"], name: "index_users_connections_on_user_a_id_and_user_b_id", unique: true
    t.index ["user_a_id"], name: "index_users_connections_on_user_a_id"
    t.index ["user_b_id", "user_a_id"], name: "index_users_connections_on_user_b_id_and_user_a_id", unique: true
    t.index ["user_b_id"], name: "index_users_connections_on_user_b_id"
  end

  add_foreign_key "users_connections", "users", column: "user_a_id"
  add_foreign_key "users_connections", "users", column: "user_b_id"
end
