class Commercial::Sale::Lead::Entity < ApplicationRecord
  
  self.table_name = "commercial_sales_leads_entities"

  # attributes

  # Storage
  
  # Relations
  belongs_to :date, class_name: "Commercial::Config::Date", foreign_key: "date_id"
  has_many :sources, class_name: "Commercial::Sale::Lead::Source", foreign_key: "lead_id", dependent: :destroy
  
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: { message: "Nome não pode ficar em branco." }
  validates :council_type, presence: { message: "Conselho não pode ficar em branco." }
  validates :council_number, presence: { message: "Conselho não pode ficar em branco." }
  validates :council_state, presence: { message: "Conselho não pode ficar em branco." }
  validates :token, presence: {message: "Token não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "Lead já existe na base. "  }, on: [:create]
  validates :uniq_phone, presence: {message: "Telefone não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "Lead já existe na base. "  }, on: [:create]
  validates :email, presence: {message: "E-mail não pode ficar em branco. "},
                    # length: {maximum: 255, message: "Tamanho de e-mail inválido. "},
                    # format: {with: VALID_EMAIL_REGEX, message: "E-mail inválido. "},
                    uniqueness: { case_sensitive: false, message: "Lead já existe na base. "  }


  #Enums
  enum status: { in_process: 0, gain: 1, lost: 2, not_contact: 3 }, _prefix: :_
            
  #Callbacks
  # before_validation :set_token
  before_validation :set_council

  def set_token
    council_type_code = self.council_type.to_s.upcase
    council_number_code = self.council_number.to_s.rjust(6,"0").upcase
    council_state_code = self.council_state.to_s.upcase

    self.token = "#{council_type_code}#{council_number_code}#{council_state_code}"
  end

  def set_council
    council_type = self.council_type.to_s.upcase

    self.council = "#{council_type}: #{CouncilDecorator.council_pretty(self)}" if self.council_number
  end
  
 # migration status
  
end


# create_table "commercial_sales_leads_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "date_id"
# t.string "name"
# t.integer "status"
# t.string "council_type"
# t.string "council_number"
# t.string "council_state"
# t.string "council"
# t.string "primary_source
# t.string "link"
# t.string "token"
# t.string "email"
# t.string "uniq_phone"
# t.string "prefix"
# t.string "phone"
# t.string "notes"