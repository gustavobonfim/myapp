class Financial::Book::Card::Transaction < ApplicationRecord

  self.table_name = "financial_card_transactions"

  # Storage
  
  # Relations
  belongs_to :card, class_name: "Financial::Book::Card::Entity", foreign_key: "card_id"
  belongs_to :bill, class_name: "Financial::Book::Card::Bill", foreign_key: "bill_id"
  belongs_to :provider, class_name: "Financial::Book::Payable::Provider", foreign_key: "provider_id"

  # Validations
  validates :token, presence: { message: "Os últimos 4 dígitos não pode ficar em branco. " },
                    uniqueness: { message: "Já existe uma fatura para este cartão. " }
  validates :pay_day, presence: {message: "O dia de pagamento não pode ficar em branco. "}
  validates :closing_day, presence: {message: "O dia de fechamento não pode ficar em branco. "}

  # Enums
  # enum invoice: { open: 0, closed: 1, paid: 2 }, _prefix: :_

  #Callbacks

end

# create_table "financial_card_transactions", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "card_id"
# t.bigint "bill_id"
# t.bigint "provider_id"
# t.date "date"
# t.date "first_pay"
# t.date "last_pay"
# t.date "pay_day"
# t.date "closing_day"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"
# t.integer "installment"
# t.string "quota"
# t.string "description"
# t.string "chart_name"
# t.string "token"
# t.string "token_tree"