class Commercial::Marketing::Landing::Lead < ApplicationRecord
  
  self.table_name = "commercial_marketing_landing_leads"

  # attributes

  # Storage
  
  # Relations
  
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: { message: "Nome não pode ficar em branco." }
  validates :ddd, presence: { message: "DDD não pode ficar em branco." }
  validates :number, presence: { message: "Número de Telefone não pode ficar em branco." }
  validates :email, presence: {message: "E-mail não pode ficar em branco. "},
                    length: {maximum: 255, message: "Tamanho de e-mail inválido. "},
                    format: {with: VALID_EMAIL_REGEX, message: "E-mail inválido. "},
                    uniqueness: { case_sensitive: false, message: "E-mail já existe na base. "  }


  #Enums

            
  #Callbacks

  
end


# create_table "commercial_marketing_landing_leads", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "name"
# t.string "last_name"
# t.string "email"
# t.string "ddd"
# t.string "number"
# t.string "crm"
# t.string "crm_state"
