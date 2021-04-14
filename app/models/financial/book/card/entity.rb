class Financial::Book::Card::Entity < ApplicationRecord

  self.table_name = "financial_card_entities"

  # Storage
  
  # Relations
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :provider, class_name: "Financial::Book::Payable::Provider", foreign_key: "provider_id"
  has_one :channel, class_name: "Financial::Book::Setting::Channel", foreign_key: "card_id"
  has_many :transactions, class_name: "Financial::Book::Card::Transaction", foreign_key: "card_id", dependent: :destroy
  has_many :bills, class_name: "Financial::Book::Card::Bill", foreign_key: "card_id", dependent: :destroy

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
# t.bigint "provider_id"
# t.integer "pay_day"
# t.integer "closing_day"
# t.integer "status"
# t.string "last_four"
# t.string "name"
# t.string "token"
# t.string "channel_name"
# t.decimal "credit_limit", precision: 15, scale: 2, default: "0.0"