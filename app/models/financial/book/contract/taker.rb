class Financial::Book::Contract::Taker < ApplicationRecord

  self.table_name = "financial_contract_takers"
  
  # Relations
  has_many :contracts, class_name: "Financial::Book::Contract::Entity", foreign_key: "taker_id"
  has_many :calculations, class_name: "Financial::Book::Contract::Calculation", foreign_key: "taker_id"
  
  # Validations
  validates :id_number, presence: {message: "O CPF/CNPJ não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "CPF/CNPJ já existe na base. "  }

  # Enums
  enum id_type: { individual: 0, legal: 1 }, _prefix: :_

  # Callbacks

end

# create_table "financial_contract_takers", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "name"
# t.string "id_number"
# t.integer "id_type"
# t.bigint "record_id"
# t.string "record_type"wwww