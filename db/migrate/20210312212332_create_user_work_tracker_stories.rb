class CreateUserWorkTrackerStories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_tracker_stories do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :project_id
      t.string :name
      t.string :description
      t.string :token
      t.string :slug
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :stage
      t.integer :status
      t.integer :total_tickets, default: 0
      t.integer :total_resolved, default: 0
      t.integer :total_canceled, default: 0
      t.integer :total_delays, default: 0
      t.integer :total_in_process, default: 0
      t.integer :total_comments, default: 0
      t.integer :total_dependents, default: 0
      t.integer :total_precedents, default: 0

    end

    add_foreign_key :user_work_tracker_stories, :user_work_tracker_projects, column: :project_id
    add_index :user_work_tracker_stories, :project_id
    add_index :user_work_tracker_stories, :stage
    add_index :user_work_tracker_stories, :status
    add_index :user_work_tracker_stories, :started_at
    add_index :user_work_tracker_stories, :finished_at
    add_index :user_work_tracker_stories, :token, unique: true
    add_index :user_work_tracker_stories, :slug, unique: true
  end
end
