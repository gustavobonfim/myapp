class User::Work::Activity::Ticket < ApplicationRecord

  self.table_name = "user_work_activity_tickets"
    
  # Relations
  belongs_to :owner, class_name: "User::Account::Entity", foreign_key: "owner_id", optional: true
  belongs_to :performer, class_name: "User::Account::Entity", foreign_key: "performer_id", optional: true
  # has_many :comments, class_name: "User::Work::Activity::Comment", foreign_key: "ticket_id", dependent: :destroy

  # Validations

  # Enums
  enum stage: { in_process: 0, resolved: 1, canceled: 2 }, _prefix: :_
  enum flag: { blue: 0, red: 1 }, _prefix: :_
  enum priority: { low: 0, medium: 1, high: 2, maximum: 3}, _prefix: :_
  enum term: { quick: 0, fast: 1, normal: 2, long: 3, large: 4}, _prefix: :_
  enum status: { in_time: 0, delay: 1}, _prefix: :_
  enum sharing: { internal: 0, external: 1}, _prefix: :_
  enum kind: { task: 0, call: 1, mail: 2, message: 3, document: 4, support: 5 }, _prefix: :_


end

# create_table "user_work_activity_tickets", force: :cascade do |t|
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "active", default: true, null: false
# t.bigint "board_id"
# t.string "board_type"
# t.string "board_name"
# t.bigint "date_id"
# t.string "date_type"
# t.bigint "owner_id"
# t.string "owner_name"
# t.bigint "performer_id"
# t.string "performer_name"
# t.string "body"
# t.date "started_at"
# t.date "due_at"
# t.datetime "finished_at"
# t.integer "duration"
# t.integer "stage"
# t.integer "status"
# t.integer "flag"
# t.integer "term"
# t.integer "sharing"
# t.integer "priority"
# t.integer "span"
# t.integer "kind"