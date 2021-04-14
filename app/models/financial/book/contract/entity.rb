class Financial::Book::Contract::Entity < ApplicationRecord

  self.table_name = "financial_contract_entities"
  
  # Relations
  belongs_to :taker, class_name: "Financial::Book::Contract::Taker", foreign_key: "taker_id"
  belongs_to :client, class_name: "Financial::Book::Contract::Taker", foreign_key: "client_id"
  # belongs_to :purchase, class_name: "Financial::Product::Purchase::Entity", foreign_key: "purchase_id"

  # Validations
  validates :started_at, presence: { message: "Falta definir a Data de Início. " }

  # Enums
  enum product_name: { medclinic: 0, medpf: 1, medfat: 2, medseg: 3, medfin: 4, medreturn: 5, medbooking: 6, medfiling: 7, medreceivement: 8, medpayroll: 9, medconsulting: 10 }, _prefix: :_
  enum product_service: { opening: 0, migration: 1, amendment: 2, regularization: 3, pos_opening: 4, separate: 5 }, _prefix: :_
  enum product_kind: { receivement: 0, practice: 1, none: 2 }, _prefix: :_
  enum status: { open: 0, churned: 1, finished: 4 }, _prefix: :_
  enum kind: { setup: 0, recurring: 1 }, _prefix: :_
  enum plan: { monthly: 0, yearly: 1 }, _prefix: :_
  

end

# create_table "financial_contract_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "purchase_id"
# t.bigint "taker_id"
# t.bigint "client_id"
# t.integer "product_name"
# t.integer "product_service"
# t.integer "product_kind"
# t.integer "kind"
# t.integer "plan"
# t.integer "status"
# t.decimal "monthly", precision: 15, scale: 2, default: "0.0"
# t.decimal "yearly", precision: 15, scale: 2, default: "0.0"
# t.decimal "total_amount", precision: 15, scale: 2, default: "0.0"
# t.boolean "prepaid", default: false
# t.integer "due_day"
# t.date "due_at"
# t.date "started_at"
# t.date "finished_at"
# t.string "finished_description"
# t.string "purchase_token"
# t.string "token"