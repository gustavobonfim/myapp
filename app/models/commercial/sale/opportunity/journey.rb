class Commercial::Sale::Opportunity::Journey < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_journeys"
  
  # Relations
  belongs_to :opportunity, class_name: "Commercial::Sale::Opportunity::Entity", foreign_key: "opportunity_id"
  
  # Validations

  # Enums
  enum status: { qualification: 0, booking: 1, meeting: 2, proposal: 3, gain: 4, lost: 5 }, _prefix: :_

  # Callbacks
  
  
end

# create_table "commercial_sales_opportunities_journeys", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "opportunity_id"
# t.integer "status"
# t.date "date"