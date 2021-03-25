class User::Work::Tracker::Project < ApplicationRecord
  
  self.table_name = "user_work_tracker_projects"

  # attributes

  # Storage
  
  # Relations
  has_many :squads, class_name: "User::Work::Tracker::Squad", foreign_key: "project_id"
  has_many :stories, class_name: "User::Work::Tracker::Story", foreign_key: "project_id"
  has_many :journeys, class_name: "User::Work::Tracker::Journey", foreign_key: "project_id"
  
  # Validations

  #Enums
  enum unit: { develop: 0, marketing: 1, financial: 2, operations: 3, people: 4 }, _prefix: :_
  enum status: { frozen: 0, in_progress: 1, canceled: 2, finished: 3 }, _prefix: :_
            
  #Callbacks
  
  
end


# create_table "user_work_tracker_projects", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.string "name"
# t.string "token"
# t.string "slug"
# t.string "description"
# t.datetime "started_at"
# t.integer "unit"
# t.integer "status"
# t.integer "total_tickets", default: 0
# t.integer "total_comments", default: 0
# t.integer "total_delays", default: 0
# t.integer "total_in_process", default: 0
# t.integer "total_squads", default: 0
# t.integer "total_stories", default: 0