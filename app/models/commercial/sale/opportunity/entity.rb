class Commercial::Sale::Opportunity::Entity < ApplicationRecord

  self.table_name = "commercial_sales_opportunities_entities"
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  # belongs_to :prospector, class_name: "User::Account::Entity", foreign_key: "prospector_id", optional: true
  # belongs_to :closer, class_name: "User::Account::Entity", foreign_key: "closer_id", optional: true
  
  # Validations
  validates :started_at, presence: { message: "Falta definir a Data de Início. " }

  #Callbacks
  
  
end

# create_table "product_dates", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.boolean "open", default: true, null: false
# t.integer "month"
# t.integer "year"
# t.string "uniq_product_date"
# t.bigint "product_id"