class Commercial::Sale::Opportunity::Journey < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_journeys"
  
  # Relations
  belongs_to :opportunity, class_name: "Commercial::Sale::Opportunity::Entity", foreign_key: "opportunity_id"
  
  # Validations

  # Enums
  enum stage: { prospecting: 0, qualification: 1, booking: 2, meeting: 3, proposal: 4, closing: 5, gain: 6, lost: 7 }, _prefix: :_

  # Callbacks
  
  
end

# create_table "commercial_sales_opportunities_journeys", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "opportunity_id"
# t.integer "stage"
# t.date "date"