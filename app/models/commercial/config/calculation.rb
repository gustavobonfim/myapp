class Commercial::Config::Calculation < ApplicationRecord

  self.table_name = "commercial_calculations"
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"

  # Validations

  #Callbacks
  

end

# create_table "commercial_calculations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.boolean "open", default: true, null: false
# t.bigint "date_id"
# t.integer "total_leads", default: 0
# t.integer "base_leads", default: 0
# t.integer "referrer_leads", default: 0
# t.integer "landings_leads", default: 0
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "base_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "referrer_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "landings_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
# t.decimal "base_gain", precision: 15, scale: 2, default: "0.0"
# t.decimal "referrer_gain", precision: 15, scale: 2, default: "0.0"
# t.decimal "landings_gain", precision: 15, scale: 2, default: "0.0"