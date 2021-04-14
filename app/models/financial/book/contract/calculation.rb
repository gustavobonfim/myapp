class Financial::Book::Contract::Calculation < ApplicationRecord

  self.table_name = "financial_contract_calculations"
  
  # Relations
  belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :taker, class_name: "Financial::Book::Contract::Taker", foreign_key: "taker_id"

  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "Sumário do Contratante já existente para o período. " }

  #Callbacks
  before_validation :set_token

  def set_token

    date_code = self.date_id.to_s(36).rjust(5,"0").upcase
    taker_code = self.taker_id.to_s(36).rjust(5,"0").upcase

    self.token = "#{date_code}#{taker_code}"
  end
  

end

# create_table "financial_contract_calculations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "taker_id"
# t.decimal "total_invoice", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_refund", precision: 15, scale: 2, default: "0.0"
# t.string "token"