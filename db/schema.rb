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

ActiveRecord::Schema.define(version: 2019_07_28_192215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beer_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.float "alcohol"
    t.integer "ibu"
    t.text "description"
    t.bigint "producer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.bigint "beer_types_id"
    t.index ["beer_types_id"], name: "index_beers_on_beer_types_id"
    t.index ["producer_id"], name: "index_beers_on_producer_id"
  end

  create_table "producers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "place"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_producers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.string "username"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "score"
    t.bigint "user_id"
    t.bigint "beer_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beer_id"], name: "index_votes_on_beer_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "beers", "beer_types", column: "beer_types_id"
  add_foreign_key "beers", "producers"
  add_foreign_key "producers", "users"
  add_foreign_key "votes", "beers"
  add_foreign_key "votes", "users"
end
