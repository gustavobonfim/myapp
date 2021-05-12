class Operation::Onboard::Date < ApplicationRecord

  self.table_name = "operation_onboard_dates"
  
  # Relations
  has_one :calculation, class_name: "Operation::Onboard::Calculation", foreign_key: "date_id", dependent: :destroy
  
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

# create_table "operation_onboard_dates", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.boolean "open", default: true, null: false
# t.integer "month"
# t.integer "year"
# t.string "token"