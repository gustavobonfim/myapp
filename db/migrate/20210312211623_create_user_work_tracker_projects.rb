class CreateUserWorkTrackerProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_tracker_projects do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.string :name
      t.string :token
      t.string :slug
      t.string :description
      t.integer :unit
      t.integer :status
      t.integer :total_tickets
      t.integer :total_comments
      t.integer :total_delays
      t.integer :total_in_process

    end

    add_index :user_work_tracker_projects, :unit
    add_index :user_work_tracker_projects, :status
    add_index :user_work_tracker_projects, :token, unique: true
    add_index :user_work_tracker_projects, :slug, unique: true
  end
end
