class Financial::Book::Contract::Additive < ApplicationRecord

  self.table_name = "financial_contract_additives"
  
  # Relations
  belongs_to :contract, class_name: "Financial::Book::Contract::Entity", foreign_key: "contract_id"

  # Validations
  validates :date, presence: { message: "Falta definir a data do Aditivo. " }
  validates :description, presence: { message: "Falta inserir a Descrição do Aditivo. " }
  validates :amount, presence: { message: "Falta definir o novo valor do Contrato. " }
  validates :kind, presence: { message: "Falta definir o Tipo de Aditivo. " }

  # Enums
  enum kind: { open: 0, frozen: 1, discount: 2, addition: 3, churned: 4, finished: 5 }, _prefix: :_

  #Callbacks

end

# create_table "financial_contract_additives", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "contract_id"
# t.date "date"
# t.string "description"
# t.decimal "amount", precision: 15, scale: 2, default: "0.0"
# t.integer "kind"