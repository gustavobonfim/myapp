class Commercial::Sale::Opportunity::Ticket < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_tickets"
  
  # Relations
  belongs_to :opportunity, class_name: "Commercial::Sale::Opportunity::Entity", foreign_key: "opportunity_id"
  
  # Validations

  # Enums
  enum stage: { in_process: 0, resolved: 1, canceled: 2 }, _prefix: :_

  enum flag: { blue: 0, red: 1 }, _prefix: :_

  enum priority: { low: 0, medium: 1, high: 2, maximum: 3}, _prefix: :_

  enum term: { quick: 0, fast: 1, normal: 2, long: 3, large: 4}, _prefix: :_

  enum status: { in_time: 0, delay: 1}, _prefix: :_

  enum sharing: { internal: 0, external: 1}, _prefix: :_

  enum kind: { call: 0, message: 1, email: 2, task: 3, document: 4}, _prefix: :_

  # Callbacks
  
  
end

# create_table "commercial_sales_opportunities_tickets", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "opportunity_id"
# t.string "body"
# t.date "due_at"
# t.integer "kind"
# t.integer "stage"
# t.integer "status"
# t.integer "flag"