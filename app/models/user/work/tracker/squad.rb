class User::Work::Tracker::Squad < ApplicationRecord
  
  self.table_name = "user_work_tracker_squads"

  # attributes
  belongs_to :project, class_name: "User::Work::Tracker::Project", foreign_key: "project_id"
  belongs_to :team, class_name: "User::Account::Entity", foreign_key: "team_id"

  # Storage
  
  # Relations
  
  # Validations


  #Enums
  enum role: { editor: 0, viewer: 1 }, _prefix: :_
            
  #Callbacks
  
  
end


# create_table "user_work_tracker_squads", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "project_id"
# t.bigint "team_id"
# t.string "team_name"
# t.integer "role"