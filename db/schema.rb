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

ActiveRecord::Schema.define(version: 2021_01_16_210451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commercial_calculations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.boolean "open", default: true, null: false
    t.bigint "date_id"
    t.integer "total_leads", default: 0
    t.integer "base_leads", default: 0
    t.integer "referrer_leads", default: 0
    t.integer "landings_leads", default: 0
    t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "base_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "referrer_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "landings_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
    t.decimal "base_gain", precision: 15, scale: 2, default: "0.0"
    t.decimal "referrer_gain", precision: 15, scale: 2, default: "0.0"
    t.decimal "landings_gain", precision: 15, scale: 2, default: "0.0"
    t.index ["active"], name: "index_commercial_calculations_on_active"
    t.index ["date_id"], name: "index_commercial_calculations_on_date_id"
  end

  create_table "commercial_dates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.boolean "open", default: true, null: false
    t.integer "month"
    t.integer "year"
    t.string "token"
    t.index ["month"], name: "index_commercial_dates_on_month"
    t.index ["token"], name: "index_commercial_dates_on_token", unique: true
    t.index ["year"], name: "index_commercial_dates_on_year"
  end

  create_table "mail_mkt_bases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.json "payload"
  end

  create_table "operation_product_booking_calculations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
  end

  create_table "operation_product_bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "operation_product_tax_returns", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "commercial_calculations", "commercial_dates", column: "date_id"
end
