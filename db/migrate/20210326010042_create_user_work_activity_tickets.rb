class CreateUserWorkActivityTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_activity_tickets do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :board_id
      t.string :board_type
      t.string :board_name
      t.bigint :date_id
      t.string :date_type
      t.bigint :owner_id
      t.string :owner_name
      t.bigint :performer_id
      t.string :performer_name
      t.string :body
      t.date :started_at
      t.date :due_at
      t.datetime :finished_at
      t.integer :duration
      t.integer :stage
      t.integer :status
      t.integer :flag
      t.integer :term
      t.integer :sharing
      t.integer :priority
      t.integer :span
      t.integer :kind
    end

    add_foreign_key :user_work_activity_tickets, :user_account_entities, column: :owner_id
    add_foreign_key :user_work_activity_tickets, :user_account_entities, column: :performer_id
    add_index :user_work_activity_tickets, :active
    add_index :user_work_activity_tickets, :board_id
    add_index :user_work_activity_tickets, :board_type
    add_index :user_work_activity_tickets, :date_id
    add_index :user_work_activity_tickets, :date_type
    add_index :user_work_activity_tickets, :owner_id
    add_index :user_work_activity_tickets, :performer_id
    add_index :user_work_activity_tickets, :duration
    add_index :user_work_activity_tickets, :stage
    add_index :user_work_activity_tickets, :status
    add_index :user_work_activity_tickets, :flag
    add_index :user_work_activity_tickets, :term
    add_index :user_work_activity_tickets, :sharing
    add_index :user_work_activity_tickets, :priority
    add_index :user_work_activity_tickets, :span
    add_index :user_work_activity_tickets, :kind
    add_index :user_work_activity_tickets, :started_at
    add_index :user_work_activity_tickets, :due_at
  end
end
