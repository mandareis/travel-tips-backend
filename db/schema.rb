# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_28_052750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.bigint "user_id", null: false
    t.bigint "suggestion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["suggestion_id"], name: "index_comments_on_suggestion_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "comment_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_likes_on_comment_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "continent", null: false
    t.string "country", null: false
    t.string "name", null: false
    t.string "city"
    t.string "admin_area"
    t.string "neighborhood"
    t.float "gps_coordinate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suggestion_scores", force: :cascade do |t|
    t.bigint "suggestion_id", null: false
    t.integer "score"
    t.index ["suggestion_id"], name: "index_suggestion_scores_on_suggestion_id"
    t.index ["suggestion_id"], name: "index_suggestion_scores_on_suggestion_id_uniq", unique: true
  end

  create_table "suggestions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "labels"
    t.bigint "place_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_suggestions_on_place_id"
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "direction", null: false
    t.bigint "user_id", null: false
    t.bigint "suggestion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["suggestion_id"], name: "index_votes_on_suggestion_id"
    t.index ["user_id", "suggestion_id"], name: "index_votes_on_user_id_and_suggestion_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "suggestions"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "comments"
  add_foreign_key "likes", "users"
  add_foreign_key "suggestion_scores", "suggestions"
  add_foreign_key "suggestions", "places"
  add_foreign_key "suggestions", "users"
  add_foreign_key "votes", "suggestions"
  add_foreign_key "votes", "users"
end
