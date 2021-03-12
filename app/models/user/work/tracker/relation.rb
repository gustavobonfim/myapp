class User::Work::Tracker::Relation < ApplicationRecord
  
  self.table_name = "user_work_tracker_relations"

  # attributes
  # belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :precedent, class_name: "User::Work::Tracker::Story", foreign_key: "precedent_id"
  belongs_to :dependent, class_name: "User::Work::Tracker::Story", foreign_key: "dependent_id"

  # Storage
  
  # Relations
  
  # Validations


  #Enums
            
  #Callbacks
  
  
end


# create_table "user_work_tracker_relations", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "precedent_id"
# t.bigint "dependent_id"
# t.string "name"
# t.boolean "status", default: false