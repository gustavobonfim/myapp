class Financial::Book::Payable::Calculation < ApplicationRecord

  self.table_name = "financial_payable_calculations"
  
  # Relations
  belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id", optional: true

  # Validations

  #Callbacks
  

end

# create_table "financial_payable_calculations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "med_id"
# t.decimal "people_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "technology_expenses", precision: 15, scale: 2, default: "0.0"