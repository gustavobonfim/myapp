class CreateOperationOnboardDates < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_onboard_dates do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.boolean :open, default: true, null: false
      t.integer :month
      t.integer :year
      t.string :token
    end

    add_index :operation_onboard_dates, :active
    add_index :operation_onboard_dates, :open
    add_index :operation_onboard_dates, :month
    add_index :operation_onboard_dates, :year
    add_index :operation_onboard_dates, :token, unique: true
  end
end
