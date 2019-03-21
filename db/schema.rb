# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_21_105844) do

  create_table "follows", force: :cascade do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id", "to_user_id"], name: "index_follows_on_from_user_id_and_to_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "screen_name"
    t.string "name"
    t.string "twitter_id"
    t.text "description"
    t.boolean "protected"
    t.text "raw"
    t.integer "followers_count"
    t.integer "friends_count"
    t.string "twitter_token"
    t.string "twitter_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_id"], name: "index_users_on_twitter_id", unique: true
  end

end
