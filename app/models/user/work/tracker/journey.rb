class User::Work::Tracker::Journey < ApplicationRecord
  
  self.table_name = "user_work_tracker_journeys"

  # attributes
  # belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :project, class_name: "User::Work::Tracker::Project", foreign_key: "project_id"

  # Storage
  
  # Relations
  
  # Validations


  #Enums
            
  #Callbacks
  
  
end


# create_table "user_work_tracker_journeys", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "project_id"
# t.string "results"
# t.datetime "date"