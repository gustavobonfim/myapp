class Financial::Book::Contract::Taker < ApplicationRecord

  self.table_name = "financial_contract_takers"
  
  # Relations
  # belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  
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
# t.string "record_type"