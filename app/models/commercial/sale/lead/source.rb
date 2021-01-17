class Commercial::Sale::Lead::Source < ApplicationRecord
  
  self.table_name = "commercial_sales_leads_sources"

  # attributes

  # Storage
  
  # Relations
  belongs_to :lead, class_name: "Commercial::Sale::Lead::Entity", foreign_key: "lead_id"
  
  # Validations
  validates :source_id, presence: { message: "A Fonte não pode ficar em branco." }

  #Enums
  enum source: { base: 0, referrer: 1, landing: 2, event: 3 }, _prefix: :_
  
            
  #Callbacks
  
end


# create_table "commercial_sales_leads_sources", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "lead_id"
# t.integer "source"
# t.bigint "source_id"
# t.string "source_type"
# t.string "name"
# t.string "kind"
# t.string "email"
# t.string "prefix"
# t.string "phone"
# t.string "council"