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

ActiveRecord::Schema[7.0].define(version: 2022_12_19_074309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_groupings", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.bigint "feed_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_group_id"], name: "index_feed_groupings_on_feed_group_id"
    t.index ["feed_id"], name: "index_feed_groupings_on_feed_id"
  end

  create_table "feed_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default"
    t.boolean "archive", default: false
  end

  create_table "followings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "feed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_followings_on_feed_id"
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "item_ogps", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "title"
    t.string "og_type"
    t.string "description"
    t.string "url"
    t.string "site_name"
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_ogps_on_item_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.string "title"
    t.string "link"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at", precision: nil
    t.index ["feed_id", "link"], name: "index_items_on_feed_id_and_link", unique: true
    t.index ["feed_id"], name: "index_items_on_feed_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "feed_groupings", "feed_groups"
  add_foreign_key "feed_groupings", "feeds"
  add_foreign_key "followings", "feeds"
  add_foreign_key "followings", "users"
  add_foreign_key "item_ogps", "items"
  add_foreign_key "items", "feeds"
end
