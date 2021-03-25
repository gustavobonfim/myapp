class User::Work::Tracker::Relation < ApplicationRecord
  
  self.table_name = "user_work_tracker_relations"

  # attributes
  # belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :precedent, class_name: "User::Work::Tracker::Story", foreign_key: "precedent_id"
  belongs_to :dependent, class_name: "User::Work::Tracker::Story", foreign_key: "dependent_id"

  # Storage
  
  # Relations
  
  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "A relação já existe " }

  #Enums
  enum role: { editor: 0, viewer: 1 }, _prefix: :_
            
  #Callbacks
  before_validation :set_token
  
  def set_token
    self.token = "relation:#{self.precedent_id}:#{self.dependent_id}"
  end
  
  
end


# create_table "user_work_tracker_relations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "precedent_id"
# t.bigint "dependent_id"
# t.string "name"
# t.string "token"
# t.boolean "status", default: false