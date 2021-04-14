class Financial::Config::Date < ApplicationRecord

  self.table_name = "financial_config_dates"
  
  # Relations Purchases
  # has_one :purchase_calculation, class_name: "Financial::Product::Purchase::Calculation", foreign_key: "date_id", dependent: :destroy
  # has_many :purchase_transaction, class_name: "Financial::Product::Purchase::Transaction", foreign_key: "date_id", dependent: :destroy

  # Relations Books
  has_many :payable_transaction, class_name: "Financial::Book::Payable::Entity", foreign_key: "date_id", dependent: :destroy
  has_one :payable_calculation, class_name: "Financial::Book::Payable::Calculation", foreign_key: "date_id", dependent: :destroy
  has_one :contract_calculation, class_name: "Financial::Book::Contract::Calculation", foreign_key: "date_id", dependent: :destroy
  # has_many :statement_transaction, class_name: "Financial::Book::Payable::Transaction", foreign_key: "date_id", dependent: :destroy

  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "Período já existente. " }

  #Callbacks
  before_validation :set_token

  def set_token

    month_code = self.month.to_s.rjust(2,"0").upcase
    year_code = self.year.to_s.rjust(4,"0").upcase

    self.token = "#{year_code}#{month_code}"
  end
  
end

# create_table "financial_config_dates", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.boolean "open", default: true, null: false
# t.integer "month"
# t.integer "year"
# t.string "token"