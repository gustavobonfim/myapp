class Commercial::Sale::Lead::Entity < ApplicationRecord
  
  self.table_name = "commercial_sales_leads_entities"

  # attributes

  # Storage
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: { message: "Nome não pode ficar em branco." }
  validates :council_type, presence: { message: "Conselho não pode ficar em branco." }
  validates :council_number, presence: { message: "Conselho não pode ficar em branco." }
  validates :council_state, presence: { message: "Conselho não pode ficar em branco." }
  validates :token, presence: {message: "Token não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "Lead já existe na base. "  }, on: [:create]
  # validates :email, presence: {message: "E-mail não pode ficar em branco. "},
  #                   length: {maximum: 255, message: "Tamanho de e-mail inválido. "},
  #                   format: {with: VALID_EMAIL_REGEX, message: "E-mail inválido. "},
  #                   uniqueness: { case_sensitive: false, message: "E-mail já existe na base. "  }


  #Enums
  
            
  #Callbacks
  before_validation :set_token
  before_validation :set_council

  def set_token
    council_type_code = self.council_type.to_s.upcase
    council_number_code = self.council_number.to_s.rjust(6,"0").upcase
    council_state_code = self.council_state.to_s.upcase

    self.token = "#{council_type_code}#{council_number_code}#{council_state_code}"
  end

  def set_council
    council_type = self.council_type.to_s.upcase

    self.council = "#{council_type}: #{CouncilDecorator.council_pretty(self)}"
  end
  

  
end


# create_table "event_attendees", force: :cascade do |t|
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
# t.string "med_school"
# t.string "token"
# t.string "slug"
# t.integer "graduation"
# t.integer "kind"