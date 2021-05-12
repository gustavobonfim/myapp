class Operation::Onboard::Entity < ApplicationRecord
  extend FriendlyId
  friendly_id :token, use: :slugged

  self.table_name = "operation_onboard_entities"
  
  # Relations
  belongs_to :date, class_name: "Operation::Onboard::Date", foreign_key: "date_id"
  belongs_to :opportunity, class_name: "Commercial::Sale::Opportunity::Opportunity", foreign_key: "opportunity_id", optional: true
  belongs_to :purchase, class_name: "Financial::Product::Purchase::Entity", foreign_key: "purchase_id", optional: true
  # has_many :parties, class_name: "Operation::Onboard::Party", foreign_key: "purchase_id", dependent: :destroy
  # has_many :journeys, class_name: "Operation::Onboard::Journey", foreign_key: "purchase_id", dependent: :destroy
  
  # Validations
  validates :started_at, presence: { message: "Falta definir a Data de Início. " }

  # Enums
  enum product_name: { medclinic: 0, medpf: 1, medfat: 2, medseg: 3, medfin: 4, medreturn: 5, medbooking: 6, medfiling: 7, medreceivement: 8, medpayroll: 9, medconsulting: 10 }, _prefix: :_
  enum product_service: { opening: 0, migration: 1, amendment: 2, regularization: 3, pos_opening: 4, separate: 5 }, _prefix: :_
  enum product_kind: { receivement: 0, practice: 1, none: 2, home: 3, employee: 4 }, _prefix: :_
  enum status: { going: 0, finished: 1, cancel: 4 }, _prefix: :_
  enum kind: { setup: 0, recurring: 1 }, _prefix: :_

  #Callbacks
  # after_create_commit :create_room

  def create_room
    ::Operation::Message::Room.create!(obj_id: self.id, obj_type: self.class.name, name: "Onboard | #{self.token}", kind: "onboard", room_type: "update")
  end
  

  def should_generate_new_friendly_id?
    self.token_changed?
  end

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
  
end