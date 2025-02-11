class Financial::Book::Receivable::Invoice < ApplicationRecord

  self.table_name = "financial_receivable_invoices"

  # Storage
  # has_one_attached :invoice

  
  # Relations
  belongs_to :taker, class_name: "Financial::Book::Contract::Taker", foreign_key: "taker_id"
  has_many :items, class_name: "Financial::Book::Receivable::InvoiceItem", foreign_key: "invoice_id", dependent: :destroy
  has_many :conciliations, class_name: "Financial::Book::Receivable::Conciliation", foreign_key: "invoice_id", dependent: :destroy
  
  # Validations
  validates :token, presence: {message: "Token do Recebível não pode ficar em branco. "},
                    uniqueness: { case_sensitive: false, message: "Já existe um Recebível com este token. "  }

  # Enums
  enum status: { pending: 0, paid: 1, canceled: 2, expired: 3, refund: 4 }, _prefix: :_
  enum method: { bank_split: 0, credit_card: 1, transfer: 2, pix: 3 }, _prefix: :_

  # Callbacks

end

# create_table "financial_receivable_invoices", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "taker_id"
# t.date "due_date"
# t.string "iugu_invoice_id"
# t.string "iugu_secure_id"
# t.string "iugu_invoice_url"
# t.string "subscription_id"
# t.string "bank_line"
# t.boolean "fines", default: false
# t.boolean "per_day_interest", default: false
# t.boolean "ignore_due_email", default: false
# t.boolean "early_payment_discount", default: false
# t.boolean "paid", default: false
# t.date "paid_at"
# t.integer "status"
# t.integer "method"
# t.integer "total_amount_cents", default: 0
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_invoice_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_refund_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_discount_amount", precision: 15, scale: 2, default: "0.0"
# t.string "token"
# t.decimal "total_income_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_reversal_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_error_amount", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_addition_amount", precision: 15, scale: 2, default: "0.0"