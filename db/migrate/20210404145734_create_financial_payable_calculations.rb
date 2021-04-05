class CreateFinancialPayableCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_payable_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.decimal :technology_staff_expenses, default: 0, precision: 15, scale: 2
      t.decimal :operation_staff_expenses, default: 0, precision: 15, scale: 2
      t.decimal :commercial_staff_expenses, default: 0, precision: 15, scale: 2
      t.decimal :administrative_staff_expenses, default: 0, precision: 15, scale: 2
      t.decimal :general_staff_expenses, default: 0, precision: 15, scale: 2
      t.decimal :sales_expenses, default: 0, precision: 15, scale: 2
      t.decimal :marketing_expenses, default: 0, precision: 15, scale: 2
      t.decimal :technology_expenses, default: 0, precision: 15, scale: 2
      t.decimal :services_expenses, default: 0, precision: 15, scale: 2
      t.decimal :administrative_expenses, default: 0, precision: 15, scale: 2
      t.decimal :general_expenses, default: 0, precision: 15, scale: 2
      t.decimal :grant_depreciation_expenses, default: 0, precision: 15, scale: 2
      t.decimal :financial_expenses, default: 0, precision: 15, scale: 2
      t.decimal :grant_losses_realization, default: 0, precision: 15, scale: 2
      t.decimal :total_staff_expenses, default: 0, precision: 15, scale: 2
      t.decimal :total_technology_expenses, default: 0, precision: 15, scale: 2
      t.decimal :total_commercial_expenses, default: 0, precision: 15, scale: 2
      t.decimal :total_operation_expenses, default: 0, precision: 15, scale: 2
      t.decimal :total_administrative_expenses, default: 0, precision: 15, scale: 2
      t.decimal :total_amount, default: 0, precision: 15, scale: 2
      t.decimal :total_paid_amount, default: 0, precision: 15, scale: 2
    end

    add_foreign_key :financial_payable_calculations, :financial_config_dates, column: :date_id
    add_foreign_key :financial_payable_calculations, :user_company_entities, column: :med_id
    add_index :financial_payable_calculations, :active
    add_index :financial_payable_calculations, :date_id
    add_index :financial_payable_calculations, :med_id
  end
end
