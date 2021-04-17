class Financial::Book::Receivable::Adjustment < ApplicationRecord

  self.table_name = "financial_receivable_adjustments"

  # Storage
  # has_one_attached :invoice

  
  # Relations
  belongs_to :financial_date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :contract, class_name: "Financial::Book::Contract::Entity", foreign_key: "contract_id"
  
  # Validations
  validates :kind, presence: {message: "O Tipo de recebimento não pode ficar em branco. "}
  validates :token, presence: {message: "Token do Recebível não pode ficar em branco. "},
                    uniqueness: { case_sensitive: false, message: "Já existe um Recebível com este token. "  }

  # Enums
  enum kind: { refund: 0, discount: 1, reversal: 2, error: 3 }, _prefix: :_
  enum status: { pending: 0, received: 1 }, _prefix: :_

  # Callbacks

end

# create_table "financial_receivable_adjustments", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "med_id"
# t.bigint "contract_id"
# t.string "contract_token"
# t.datetime "due_date"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"
# t.string "description"
# t.integer "kind"
# t.string "token"
# t.integer "status"
# t.boolean "received", default: false