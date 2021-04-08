class Financial::Book::Card::Entity < ApplicationRecord

  self.table_name = "financial_card_entities"

  # Storage
  
  # Relations
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"

  # Validations
  validates :last_four, presence: {message: "Os últimos 4 dígitos não pode ficar em branco. "}
  validates :pay_day, presence: {message: "O dia de pagamento não pode ficar em branco. "}
  validates :closing_day, presence: {message: "O dia de fechamento não pode ficar em branco. "}

  # Enums
  # enum method: { bank_split: 0, credit_card: 1, transfer: 2, pix: 3 }, _prefix: :_

  # Callbacks

end

# create_table "financial_card_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "med_id"
# t.integer "pay_day"
# t.integer "closing_day"
# t.integer "status"
# t.string "last_four"
# t.string "name"
# t.string "token"
# t.decimal "credit_limit", precision: 15, scale: 2, default: "0.0"