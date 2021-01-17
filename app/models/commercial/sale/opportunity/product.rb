class Commercial::Sale::Opportunity::Product < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_products"
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  belongs_to :opportunity, class_name: "Commercial::Sale::Opportunity::Entity", foreign_key: "opportunity_id"
  
  # Validations

  # Enums
  enum name: { medpj: 0, medpf: 1, medfat: 2, medseg: 3, medfin: 4, medreturn: 5, medbooking: 6, medfiling: 7 }, _prefix: :_
  enum kind: { receivement: 0, practice: 1 }, _prefix: :_

  # Callbacks
  
  
end

# create_table "commercial_sales_opportunities_products", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "opportunity_id"
# t.integer "name"
# t.integer "kind"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"