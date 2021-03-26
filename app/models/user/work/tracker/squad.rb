class User::Work::Tracker::Squad < ApplicationRecord
  
  self.table_name = "user_work_tracker_squads"

  # attributes

  # Storage
  
  # Relations
  belongs_to :project, class_name: "User::Work::Tracker::Project", foreign_key: "project_id"
  belongs_to :team, class_name: "User::Account::Entity", foreign_key: "team_id"
  
  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "O parceiro já faz parte desse Projeto! " }

  #Enums
  enum role: { owner: 0, editor: 1, viewer: 2 }, _prefix: :_
            
  #Callbacks
  before_validation :set_token
  
  def set_token
    self.token = "squad:#{self.project_id}:#{self.team_id}"
  end
  
  
end

# create_table "user_work_tracker_squads", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "project_id"
# t.bigint "team_id"
# t.string "team_name"
# t.string "token"
# t.integer "role"
# t.integer "total_tickets", default: 0
# t.integer "total_comments", default: 0
# t.integer "total_delays", default: 0
# t.integer "total_in_process", default: 0