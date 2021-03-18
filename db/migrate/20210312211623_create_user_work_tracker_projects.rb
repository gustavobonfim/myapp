class CreateUserWorkTrackerProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_tracker_projects do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :token
      t.string :slug
      t.string :description
      t.datetime :started_at
      t.integer :unit
      t.integer :status
      t.integer :total_tickets, default: 0
      t.integer :total_comments, default: 0
      t.integer :total_delays, default: 0
      t.integer :total_in_process, default: 0
      t.integer :total_teams, default: 0
      t.integer :total_stories, default: 0

    end

    add_index :user_work_tracker_projects, :unit
    add_index :user_work_tracker_projects, :status
    add_index :user_work_tracker_projects, :token, unique: true
    add_index :user_work_tracker_projects, :slug, unique: true
  end
end
