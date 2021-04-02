class Financial::Balance::Payable::Provider < ApplicationRecord

  self.table_name = "financial_payable_providers"
  
  # Relations
  # belongs_to :date, class_name: "Financial::Config::Date", foreign_key: "date_id"
  
  # Validations
  validates :id_number, presence: {message: "O CPF/CNPJ não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "CPF/CNPJ já existe na base. "  }

  # Enums
  enum id_type: { individual: 0, legal: 1 }, _prefix: :_

  # Callbacks
  
  
end

# Financial::Balance::Payable::Provider.new(name: "Gustavo Bonfim", id_number: "07412332660", id_type: "individual")

# create_table "financial_payable_providers", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "name"
# t.string "id_number"
# t.integer "id_type"
# t.bigint "record_id"
# t.string "record_type"