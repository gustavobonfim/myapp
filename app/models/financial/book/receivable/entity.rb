class Financial::Book::Receivable::Entity < ApplicationRecord

  self.table_name = "financial_receivable_entities"

  # Storage
  # has_one_attached :invoice

  
  # Relations
  belongs_to :financial_date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  belongs_to :channel, class_name: "Financial::Book::Setting::Channel", foreign_key: "channel_id"
  belongs_to :chart, class_name: "Financial::Book::Setting::ChartAccount", foreign_key: "chart_id"
  belongs_to :contract, class_name: "Financial::Book::Contract::Entity", foreign_key: "contract_id"
  
  # Validations
  validates :kind, presence: {message: "O Tipo de recebimento não pode ficar em branco. "}
  validates :token, presence: {message: "Token do Recebível não pode ficar em branco. "},
                    uniqueness: { case_sensitive: false, message: "Já existe um Recebível com este token. "  }

  # Enums
  enum method: { bank_split: 0, credit_card: 1, transfer: 2, pix: 3, invoice: 4 }, _prefix: :_
  enum kind: { income: 0, refund: 1, discount: 2, reversal: 3, error: 4 }, _prefix: :_

  # Callbacks
  before_validation :set_token

  def set_token
    contract_code = self.contract_token
    date_code = self.date_id.to_s(36).rjust(4,"0").upcase if self.date_id
    kind_code = self.defined_enums["kind"][self.kind].to_s.rjust(2,"0")

    self.token = "#{contract_code}-#{date_code}-#{kind_code}"
  end

end

# create_table "financial_receivable_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.bigint "chart_id"
# t.bigint "med_id"
# t.bigint "channel_id"
# t.bigint "contract_id"
# t.string "contract_token"
# t.datetime "due_date"
# t.datetime "received_date"
# t.integer "received_span"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"
# t.string "description"
# t.string "chart_account"
# t.string "chart_name"
# t.string "chart_master_name"
# t.string "chart_group"
# t.integer "kind"
# t.integer "method"
# t.string "channel_name"
# t.string "bank_line"
# t.boolean "received", default: false
# t.boolean "recurring", default: false
# t.string "token"