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
# t.integer "goal_leads", default: 0
# t.decimal "goal_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "goal_gain", precision: 15, scale: 2, default: "0.0"
# t.integer "marketing_leads", default: 0
# t.integer "sales_leads", default: 0
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_gain", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_lost", precision: 15, scale: 2, default: "0.0"
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
# t.integer "total_in_process", default: 0
# t.integer "prospecting_count", default: 0
# t.integer "qualification_count", default: 0
# t.integer "booking_count", default: 0
# t.integer "meeting_count", default: 0
# t.integer "proposal_count", default: 0
# t.integer "closing_count", default: 0
# t.integer "gain_count", default: 0
# t.integer "lost_count", default: 0
# t.decimal "prospecting_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "qualification_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "booking_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "meeting_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "proposal_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "closing_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "gain_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "lost_amount", precision: 15, scale: 2, default: "0.0"