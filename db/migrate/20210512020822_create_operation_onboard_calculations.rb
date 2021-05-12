class CreateOperationOnboardCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :operation_onboard_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.boolean :open, default: true, null: false
      t.bigint :date_id
      t.integer :total_onboard, default: 0
      t.integer :total_setup, default: 0
      t.integer :total_recurring, default: 0
      t.integer :medclinic, default: 0
      t.integer :medreturn, default: 0
      t.integer :medfiling, default: 0
      t.integer :medbooking, default: 0
      t.integer :medpayroll, default: 0
      t.integer :medbiling, default: 0
      t.integer :medreceivement, default: 0
      t.integer :medseg, default: 0
      t.integer :medbanking, default: 0
      t.integer :total_tickets, default: 0
      t.integer :total_comments, default: 0
      t.integer :total_delays, default: 0
      t.integer :total_in_process, default: 0
      t.integer :total_notes, default: 0
      t.decimal :total_medclinic, default: 0, precision: 15, scale: 2
      t.decimal :total_medreturn, default: 0, precision: 15, scale: 2
      t.decimal :total_medfiling, default: 0, precision: 15, scale: 2
      t.decimal :total_medbooking, default: 0, precision: 15, scale: 2
      t.decimal :total_medpayroll, default: 0, precision: 15, scale: 2
      t.decimal :total_medbiling, default: 0, precision: 15, scale: 2
      t.decimal :total_medreceivement, default: 0, precision: 15, scale: 2
      t.decimal :total_medseg, default: 0, precision: 15, scale: 2
      t.decimal :total_medbanking, default: 0, precision: 15, scale: 2
      t.decimal :total_mrr_new, default: 0, precision: 15, scale: 2
      t.decimal :total_mrr_increase, default: 0, precision: 15, scale: 2
      t.decimal :total_mrr_decrease, default: 0, precision: 15, scale: 2
      t.decimal :total_mrr_churn, default: 0, precision: 15, scale: 2
      t.decimal :total_monthly, default: 0, precision: 15, scale: 2
      t.decimal :total_yearly, default: 0, precision: 15, scale: 2
      t.decimal :total_setup_amount_accrual, default: 0, precision: 15, scale: 2
      t.decimal :total_recurring_amount_accrual, default: 0, precision: 15, scale: 2
    end

    add_foreign_key :operation_onboard_calculations, :operation_onboard_dates, column: :date_id
    add_index :operation_onboard_calculations, :date_id
    add_index :operation_onboard_calculations, :active
  end
end
