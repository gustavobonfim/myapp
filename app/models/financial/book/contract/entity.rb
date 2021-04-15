class Financial::Book::Contract::Entity < ApplicationRecord

  self.table_name = "financial_contract_entities"
  
  # Relations
  belongs_to :taker, class_name: "Financial::Book::Contract::Taker", foreign_key: "taker_id"
  belongs_to :client, class_name: "Financial::Book::Contract::Taker", foreign_key: "client_id"
  belongs_to :channel, class_name: "Financial::Book::Setting::Channel", foreign_key: "channel_id"
  belongs_to :med, class_name: "User::Company::Entity", foreign_key: "med_id"
  # belongs_to :purchase, class_name: "Financial::Product::Purchase::Entity", foreign_key: "purchase_id"

  # Validations
  validates :started_at, presence: { message: "Falta definir a Data de Início. " }
  validates :token, presence: {message: "Token do Contrato não pode ficar em branco. "},
                    uniqueness: { case_sensitive: false, message: "Já existe um Contrato com este token. "  }

  # Enums
  enum product_name: { medclinic: 0, medpf: 1, medfat: 2, medseg: 3, medfin: 4, medreturn: 5, medbooking: 6, medfiling: 7, medreceivement: 8, medpayroll: 9, medconsulting: 10 }, _prefix: :_
  enum product_service: { opening: 0, migration: 1, amendment: 2, regularization: 3, pos_opening: 4, separate: 5 }, _prefix: :_
  enum product_kind: { receivement: 0, practice: 1, none: 2 }, _prefix: :_
  enum status: { open: 0, churned: 1, finished: 4 }, _prefix: :_
  enum kind: { setup: 0, recurring: 1 }, _prefix: :_
  enum plan: { monthly: 0, yearly: 1 }, _prefix: :_
  enum method: { bank_split: 0, credit_card: 1, transfer: 2, pix: 3 }, _prefix: :_
  
  #Callbacks
  before_validation :set_name

  def set_name
    product_name_pretty = ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_NAME[self.product_name]
    product_service_pretty = ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_SERVICE[self.product_service]
    product_kind_pretty = ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_KIND[self.product_kind]
    kind_pretty = ::Financials::Books::Contracts::EntityRepository::ENUM_KIND[self.kind]
    plan_pretty = ::Financials::Books::Contracts::EntityRepository::ENUM_PLAN[self.plan]

    self.name = "Contrato #{kind_pretty} #{plan_pretty} #{product_name_pretty} #{product_kind_pretty}"
    # self.name = "Contrato #{Recorrente} #{Mensal} #{PJ Médica} #{Recebimento}"
    # self.name = "Contrato #{kind_pretty} #{plan_pretty} #{product_service_pretty} #{product_name_pretty} #{product_kind_pretty}"
  end

end

# create_table "financial_contract_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "taker_id"
# t.bigint "client_id"
# t.bigint "channel_id"
# t.bigint "med_id"
# t.integer "product_name"
# t.integer "product_service"
# t.integer "product_kind"
# t.integer "kind"
# t.integer "plan"
# t.integer "status"
# t.decimal "monthly", precision: 15, scale: 2, default: "0.0"
# t.decimal "yearly", precision: 15, scale: 2, default: "0.0"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"
# t.boolean "prepaid", default: false
# t.boolean "same_value", default: false
# t.integer "due_day"
# t.integer "start_month"
# t.integer "start_year"
# t.date "due_at"
# t.date "started_at"
# t.date "finished_at"
# t.string "channel_name"
# t.string "finished_description"
# t.string "purchase_token"
# t.string "token"
# t.string "name"
# t.integer "method"