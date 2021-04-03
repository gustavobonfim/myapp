class Financial::Balance::Payable::Entity < ApplicationRecord

  self.table_name = "financial_payable_entities"
  
  # Relations
  belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :channel, class_name: "Financial::Balance::Setting::Channel", foreign_key: "channel_id"
  belongs_to :chart, class_name: "Financial::Balance::Setting::ChartAccount", foreign_key: "chart_id"
  
  # Validations
  validates :method, presence: {message: "O método de pagamento não pode ficar em branco. "}

  # Enums
  enum method: { bank_split: 0, credit_card: 1, transfer: 2, pix: 3 }, _prefix: :_

  # Callbacks

end

# create_table "financial_payable_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "chart_id"
# t.bigint "med_id"
# t.bigint "channel_id"
# t.bigint "provider_id"
# t.string "provider_name"
# t.datetime "due_date"
# t.datetime "accrual_date"
# t.decimal "amount", precision: 15, scale: 2
# t.string "description"
# t.string "chart_account"
# t.string "chart_name"
# t.integer "method"
# t.string "channel_name"
# t.string "bank_line"
# t.boolean "paid", default: false
# t.boolean "recurring", default: false
# t.boolean "splited", default: false
# t.integer "split"
# t.integer "installment"
# t.string "token"