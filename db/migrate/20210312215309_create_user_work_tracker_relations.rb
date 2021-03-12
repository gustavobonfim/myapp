class CreateUserWorkTrackerRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_work_tracker_relations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :precedent_id
      t.bigint :dependent_id
      t.string :name
      t.boolean :status, default: false
    end

    add_foreign_key :user_work_tracker_relations, :user_work_tracker_stories, column: :precedent_id
    add_foreign_key :user_work_tracker_relations, :user_work_tracker_stories, column: :dependent_id
    add_index :user_work_tracker_relations, :precedent_id
    add_index :user_work_tracker_relations, :dependent_id
    add_index :user_work_tracker_relations, :status
  end
end
