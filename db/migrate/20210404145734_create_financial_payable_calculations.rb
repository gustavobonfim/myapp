class CreateFinancialPayableCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_payable_calculations do |t|
      t.timestamps
      t.boolean :active, default: true, null: false
      t.bigint :date_id
      t.bigint :med_id
      t.decimal :people_expenses, default: 0, precision: 15, scale: 2
      t.decimal :technology_expenses, default: 0, precision: 15, scale: 2
    end

    add_foreign_key :financial_payable_calculations, :financial_config_dates, column: :date_id
    add_foreign_key :financial_payable_calculations, :user_company_entities, column: :med_id
    add_index :financial_payable_calculations, :active
    add_index :financial_payable_calculations, :date_id
    add_index :financial_payable_calculations, :med_id
  end
end
