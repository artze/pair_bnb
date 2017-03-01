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

ActiveRecord::Schema.define(version: 20170301041553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",          precision: 10, scale: 2
    t.string   "home_type"
    t.string   "room_type"
    t.integer  "bedroom"
    t.integer  "bathroom"
    t.integer  "accommodate"
    t.integer  "user_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.text     "images",                                  default: [],              array: true
    t.string   "street_address"
    t.string   "postcode"
    t.string   "city"
    t.string   "country"
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "listings_tags", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id", "tag_id"], name: "index_listings_tags_on_listing_id_and_tag_id", unique: true, using: :btree
    t.index ["listing_id"], name: "index_listings_tags_on_listing_id", using: :btree
    t.index ["tag_id"], name: "index_listings_tags_on_tag_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.date     "booking_start"
    t.date     "booking_end"
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "status"
    t.index ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "listings", "users"
  add_foreign_key "listings_tags", "listings"
  add_foreign_key "listings_tags", "tags"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users"
end
