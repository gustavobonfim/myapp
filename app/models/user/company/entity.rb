class User::Company::Entity < ApplicationRecord
  include CnpjValidates
  extend FriendlyId
  friendly_id :token, use: :slugged

  self.table_name = "user_company_entities"

  attr_accessor :email, :phone, :cnpj_pretty

  
  # Relations
  
  # has_many :emails, class_name: "Contact::Email", foreign_key: "company_id" #, dependent: :destroy
  # has_many :phones, class_name: "Contact::Phone", foreign_key: "company_id" #, dependent: :destroy
  # has_many :addresses, class_name: "Contact::Address", foreign_key: "company_id" #, dependent: :destroy
  


  # Validations
  validates :trade_name, presence: { message: "Por favor, insira a Razão Social. " },
                         uniqueness: { case_sensitive: false, message: "Razão Social já existe na base. " }
  validates :name, presence: { message: "Por favor, insira o Nome Fantasia. " }
  validates :kind, presence: { message: "Falta o tipo de Empresa. " }
  validate :cnpj_validate
  validates :cnpj, presence: { message: "Por favor, insira o CNPJ. " },
                  uniqueness: { case_sensitive: false, message: "CNPJ já existe na base. " },
                  length: { in: 14..14, message: "Formato errado do CNPJ. " }
  

  #Callbacks

  #Enums
  # enum kind: { clinic: 0, pjtaker: 1, provider: 2, operator: 3, supplier: 4, med: 5 }, _prefix: :_


  def cnpj_pretty
    ::CompanyDecorator.new(self).cnpj_pretty
  end

  def should_generate_new_friendly_id?
    self.token_changed?
  end

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
   
end


# create_table "company_entities", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "name"
# t.string "trade_name"
# t.string "cnpj"
# t.string "kind", array: true
# t.string "subkind", array: true
# t.string "slug"
# t.date "opened_at"
# t.text "notes"