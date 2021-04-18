class Financial::Book::Receivable::Calculation < ApplicationRecord

  self.table_name = "financial_receivable_calculations"
  
  # Relations
  belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id", optional: true

  # Validations
  validates :token, presence: {message: "Token do Indicador de Contas a Receber não pode ficar em branco. "},
                    uniqueness: { case_sensitive: false, message: "Já existe um Indicador de Contas a Receber com este token. "  }

  #Callbacks
  before_validation :set_token

  def set_token

    date_code = self.date_id.to_s(36).rjust(5,"0").upcase
    med_code = self.med_id.to_s(36).rjust(5,"0").upcase

    self.token = "#{date_code}#{med_code}"
  end
  

end

# create_table "financial_receivable_calculations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "med_id"
# t.decimal "medclinic", precision: 15, scale: 2, default: "0.0"
# t.decimal "medbooking", precision: 15, scale: 2, default: "0.0"
# t.decimal "medfiling", precision: 15, scale: 2, default: "0.0"
# t.decimal "medpayroll", precision: 15, scale: 2, default: "0.0"
# t.decimal "medreceivement", precision: 15, scale: 2, default: "0.0"
# t.decimal "medbiling", precision: 15, scale: 2, default: "0.0"
# t.decimal "medinvestment", precision: 15, scale: 2, default: "0.0"
# t.decimal "medprotection", precision: 15, scale: 2, default: "0.0"
# t.decimal "medconsulting", precision: 15, scale: 2, default: "0.0"
# t.decimal "interests_revenues", precision: 15, scale: 2, default: "0.0"
# t.decimal "exchange_variation_revenues", precision: 15, scale: 2, default: "0.0"
# t.decimal "miscellaneous_revenues", precision: 15, scale: 2, default: "0.0"
# t.decimal "accounting", precision: 15, scale: 2, default: "0.0"
# t.decimal "biling", precision: 15, scale: 2, default: "0.0"
# t.decimal "investment", precision: 15, scale: 2, default: "0.0"
# t.decimal "protection", precision: 15, scale: 2, default: "0.0"
# t.decimal "miscellaneous", precision: 15, scale: 2, default: "0.0"
# t.decimal "financial_revenues", precision: 15, scale: 2, default: "0.0"
# t.decimal "final_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_income_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_refund_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_discount_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_received_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_income_received_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_refund_received_amount", precision: 15, scale: 2, default: "0.0"
# t.string "token"
# t.decimal "total_invoice_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_reversal_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_error_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_discount_received_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_reversal_received_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_error_received_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_invoice_received_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_addition_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_addition_received_amount", precision: 15, scale: 2, default: "0.0"