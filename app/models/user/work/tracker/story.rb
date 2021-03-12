class User::Work::Tracker::Story < ApplicationRecord
  
  self.table_name = "user_work_tracker_stories"

  # attributes
  # belongs_to :account, class_name: "User::Account::Entity", foreign_key: "account_id", optional: true
  belongs_to :project, class_name: "User::Work::Tracker::Project", foreign_key: "project_id"

  # Storage
  
  # Relations
  
  # Validations


  #Enums
  enum status: { in_progress: 0, frozen: 1 }, _prefix: :_
  enum stage: { icebox: 0, backlog: 1, current: 2, done: 3 }, _prefix: :_
            
  #Callbacks
  
  
end


# create_table "user_work_tracker_stories", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "project_id"
# t.string "name"
# t.string "description"
# t.string "token"
# t.string "slug"
# t.datetime "started_at"
# t.datetime "finished_at"
# t.integer "stage"
# t.integer "status"
# t.integer "total_tickets"
# t.integer "total_comments"
# t.integer "total_delays"
# t.integer "total_in_process"