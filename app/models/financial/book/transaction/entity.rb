class Financial::Book::Transaction::Entity < ApplicationRecord

  self.table_name = "financial_transaction_entities"
  
  # Relations
  belongs_to :financial_date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :channel, class_name: "Financial::Book::Setting::Channel", foreign_key: "channel_id", optional: true
  belongs_to :from, class_name: "Financial::Book::Setting::ChartAccount", foreign_key: "from_id"
  belongs_to :to, class_name: "Financial::Book::Setting::ChartAccount", foreign_key: "to_id"
  
  # Validations
  validates :method, presence: {message: "O método de pagamento não pode ficar em branco. "}
  validates :kind, presence: {message: "O tipo de transação não pode ficar em branco. "}

  # Enums
  enum method: { bank_split: 0, credit_card: 1, transfer: 2, pix: 3 }, _prefix: :_
  enum kind: { statement: 0, balance: 1 }, _prefix: :_

  # Callbacks

end

# create_table "financial_transaction_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "med_id"
# t.bigint "channel_id"
# t.bigint "from_id"
# t.bigint "to_id"
# t.string "from_master_name"
# t.string "from_group"
# t.string "from_master_group"
# t.string "from_master"
# t.string "to_master_name"
# t.string "to_group"
# t.string "to_master_group"
# t.string "to_master"
# t.decimal "amount", precision: 15, scale: 2
# t.decimal "from_amount", precision: 15, scale: 2
# t.decimal "to_amount", precision: 15, scale: 2
# t.datetime "date"
# t.string "description"
# t.integer "method"
# t.string "channel_name"
# t.boolean "recurring", default: false
# t.integer "installment"
# t.string "token_tree"
# t.integer "kind"