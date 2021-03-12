class User::Work::Tracker::Project < ApplicationRecord
  
  self.table_name = "user_work_tracker_projects"

  # attributes

  # Storage
  
  # Relations
  
  # Validations

  #Enums
  enum unit: { develop: 0, marketing: 1 }, _prefix: :_
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
# t.integer "unit"
# t.integer "status"
# t.integer "total_tickets"
# t.integer "total_comments"
# t.integer "total_delays"
# t.integer "total_in_process"