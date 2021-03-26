class User::Work::Tracker::Story < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  self.table_name = "user_work_tracker_stories"

  # attributes

  # Storage
  
  # Relations
  belongs_to :project, class_name: "User::Work::Tracker::Project", foreign_key: "project_id"
  has_many :relation_precedents, class_name: "User::Work::Tracker::Relation", foreign_key: "precedent_id", dependent: :destroy
  has_many :relation_dependents, class_name: "User::Work::Tracker::Relation", foreign_key: "dependent_id", dependent: :destroy
  has_many :precedents, through: :relation_precedents
  has_many :dependents, through: :relation_dependents
  
  # Validations
  validates :token, uniqueness: { case_sensitive: false, message: "O Entregável já existe " }

  #Enums
  enum status: { in_process: 0, frozen: 1 }, _prefix: :_
  enum stage: { icebox: 0, backlog: 1, current: 2, done: 3 }, _prefix: :_
            
  #Callbacks
  before_validation :set_token
  
  def set_token
    self.token = "story:#{self.project_id}:#{self.name}"
  end
  
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
# t.integer "total_tickets", default: 0
# t.integer "total_comments", default: 0
# t.integer "total_delays", default: 0
# t.integer "total_in_process", default: 0
# t.integer "total_dependents", default: 0
# t.integer "total_precedents", default: 0