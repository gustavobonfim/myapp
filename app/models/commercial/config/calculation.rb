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
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "base_leads", default: 0
# t.decimal "base_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "base_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "referrer_leads", default: 0
# t.decimal "referrer_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "referrer_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "landing_leads", default: 0
# t.decimal "landing_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "landing_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "event_leads", default: 0
# t.decimal "event_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "event_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "total_tickets", default: 0
# t.integer "total_calls", default: 0
# t.integer "total_contacts", default: 0
# t.integer "total_documents", default: 0
# t.integer "total_prospecting", default: 0
# t.integer "total_qualification", default: 0
# t.integer "total_booking", default: 0
# t.integer "total_meeting", default: 0
# t.integer "total_proposal", default: 0
# t.integer "total_closing", default: 0