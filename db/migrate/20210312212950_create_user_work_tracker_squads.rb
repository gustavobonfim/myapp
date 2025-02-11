class CreateUserWorkTrackerSquads < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_tracker_squads do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :project_id
      t.bigint :team_id
      t.string :team_name
      t.string :token
      t.integer :role
      t.integer :total_tickets, default: 0
      t.integer :total_comments, default: 0
      t.integer :total_delays, default: 0
      t.integer :total_in_process, default: 0
    end

    add_foreign_key :user_work_tracker_squads, :user_work_tracker_projects, column: :project_id
    add_foreign_key :user_work_tracker_squads, :user_account_entities, column: :team_id
    add_index :user_work_tracker_squads, :project_id
    add_index :user_work_tracker_squads, :team_id
    add_index :user_work_tracker_squads, :role
    add_index :user_work_tracker_squads, :token, unique: true
  end
end
