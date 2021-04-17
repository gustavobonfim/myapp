class Financial::Book::Receivable::InvoiceItem < ApplicationRecord

  self.table_name = "financial_receivable_invoice_items"
  
  # Relations
  belongs_to :invoice, class_name: "Financial::Book::Receivable::Invoice", foreign_key: "invoice_id"

  # Validations
  validates :description, presence: {message: "A Descrição não pode ficar em branco. "}
  validates :price_cents, presence: {message: "O Preço não pode ficar em branco. "}
  validates :quantity, presence: {message: "A Quantidade não pode ficar em branco. "}
  validates :kind, presence: {message: "O Tipo não pode ficar em branco. "}
  validates :amount, presence: {message: "O Valor não pode ficar em branco. "}

  # Enums
  enum kind: { income: 0, refund: 1, discount: 2, reversal: 3, error: 4 }, _prefix: :_

  #Callbacks
  

end

# create_table "financial_receivable_invoice_items", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "invoice_id"
# t.string "description"
# t.integer "price_cents"
# t.integer "quantity"
# t.integer "kind"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"