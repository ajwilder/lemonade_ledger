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

ActiveRecord::Schema.define(version: 20180119155805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.text "employees", default: [], array: true
    t.text "locations", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "days", force: :cascade do |t|
    t.text "employees", default: [], array: true
    t.string "location"
    t.boolean "closed", default: false
    t.float "cash_start"
    t.float "cash_end"
    t.integer "large_start", default: 0
    t.integer "large_restock", default: 0
    t.integer "large_end", default: 0
    t.integer "large_discrepancy", default: 0
    t.integer "small_start", default: 0
    t.integer "small_restock", default: 0
    t.integer "small_end", default: 0
    t.integer "small_discrepancy", default: 0
    t.integer "bottle_start", default: 0
    t.integer "bottle_restock", default: 0
    t.integer "bottle_end", default: 0
    t.integer "bottle_discrepancy", default: 0
    t.integer "hot_medium_start", default: 0
    t.integer "hot_medium_restock", default: 0
    t.integer "hot_medium_end", default: 0
    t.integer "hot_medium_discrepancy", default: 0
    t.integer "hot_small_start", default: 0
    t.integer "hot_small_restock", default: 0
    t.integer "hot_small_end", default: 0
    t.integer "hot_small_discrepancy", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "drink_type"
    t.string "cup_type"
    t.float "price"
    t.boolean "active", default: true
    t.float "vendor_price"
  end

  create_table "sales", force: :cascade do |t|
    t.text "items", default: [], array: true
    t.float "price"
    t.integer "large"
    t.integer "small"
    t.integer "bottle"
    t.integer "hot_medium"
    t.integer "hot_small"
    t.boolean "discount", default: false
    t.bigint "day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_sales_on_day_id"
  end

  add_foreign_key "sales", "days"
end
