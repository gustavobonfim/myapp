class CreateCommercialCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.boolean :open, default: true, null: false
      t.bigint :date_id
      t.integer :goal_leads, default: 0
      t.decimal :goal_amount, default: 0, precision: 15, scale: 2
      t.decimal :goal_gain, default: 0, precision: 15, scale: 2
      t.integer :marketing_leads, default: 0
      t.integer :sales_leads, default: 0
      t.decimal :total_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_gain, default: 0, precision: 15, scale: 2
      t.decimal :total_lost, default: 0, precision: 15, scale: 2
      t.integer :base_leads, default: 0
      t.decimal :base_amount, default: 0, precision: 15, scale: 2
      t.decimal :base_gain, default: 0, precision: 15, scale: 2
      t.integer :referrer_leads, default: 0
      t.decimal :referrer_amount, default: 0, precision: 15, scale: 2
      t.decimal :referrer_gain, default: 0, precision: 15, scale: 2
      t.integer :landing_leads, default: 0
      t.decimal :landing_amount, default: 0, precision: 15, scale: 2
      t.decimal :landing_gain, default: 0, precision: 15, scale: 2
      t.integer :event_leads, default: 0
      t.decimal :event_amount, default: 0, precision: 15, scale: 2
      t.decimal :event_gain, default: 0, precision: 15, scale: 2
      t.integer :total_tickets, default: 0
      t.integer :total_calls, default: 0
      t.integer :total_contacts, default: 0
      t.integer :total_in_process, default: 0
      t.integer :count_prospecting, default: 0
      t.integer :count_qualification, default: 0
      t.integer :count_booking, default: 0
      t.integer :count_meeting, default: 0
      t.integer :count_proposal, default: 0
      t.integer :count_closing, default: 0
      t.integer :count_gain, default: 0
      t.integer :count_lost, default: 0
    end

    add_foreign_key :commercial_calculations, :commercial_dates, column: :date_id
    add_index :commercial_calculations, :date_id
    add_index :commercial_calculations, :active
  end
end
