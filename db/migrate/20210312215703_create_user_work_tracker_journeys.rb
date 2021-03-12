class CreateUserWorkTrackerJourneys < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_tracker_journeys do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :project_id
      t.string :results
      t.datetime :date
    end

    add_foreign_key :user_work_tracker_journeys, :user_work_tracker_projects, column: :project_id
    add_index :user_work_tracker_journeys, :active
    add_index :user_work_tracker_journeys, :project_id
    add_index :user_work_tracker_journeys, :date
  end
end
