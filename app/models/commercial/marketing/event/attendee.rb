class Commercial::Marketing::Event::Attendee < ApplicationRecord
  extend FriendlyId
  friendly_id :token, use: :slugged
  
  self.table_name = "commercial_marketing_event_attendees"

  # attributes

  # Storage
  
  # Relations
  
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :name, presence: { message: "Nome não pode ficar em branco." }
  # validates :ddd, presence: { message: "DDD não pode ficar em branco." }
  # validates :number, presence: { message: "Número de Telefone não pode ficar em branco." }
  # validates :token, presence: {message: "Token não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "Token já existe na base. "  }, on: [:create]
  # validates :email, presence: {message: "E-mail não pode ficar em branco. "},
  #                   length: {maximum: 255, message: "Tamanho de e-mail inválido. "},
  #                   format: {with: VALID_EMAIL_REGEX, message: "E-mail inválido. "},
  #                   uniqueness: { case_sensitive: false, message: "E-mail já existe na base. "  }


  #Enums
  enum kind: { academic: 0,
               doctor: 1,
               not_doctor: 2 }, _prefix: :_

            
  #Callbacks
  # after_find :set_attr_accessors
  # before_save :inactive_instructions
  
  def should_generate_new_friendly_id?
    self.token_changed?
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