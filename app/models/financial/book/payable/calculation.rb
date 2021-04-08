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
# t.decimal "technology_staff_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "operation_staff_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "commercial_staff_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "administrative_staff_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "general_staff_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "sales_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "marketing_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "technology_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "services_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "administrative_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "general_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "grant_depreciation_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "financial_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "grant_losses_realization", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_staff_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_technology_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_commercial_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_operation_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_administrative_expenses", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_paid_amount", precision: 15, scale: 2, default: "0.0"